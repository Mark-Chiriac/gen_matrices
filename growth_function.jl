using LinearAlgebra
using SparseArrays
using Plots
include("genMat.jl")

function deg_test(n)
    X = gen_X(n)
    Y = gen_Y(n)
    dimVprev = 0
    growth_list = []
    for deg = 1:n
        monomials_in_deg = gen_monomials(X,Y, deg)
        matrix_stack = flatten_matrices(monomials_in_deg)
        dimVnew = rank(matrix_stack, atol=1e-10)
        growth = dimVnew- dimVprev
        push!(growth_list, growth)
        dimVprev = dimVnew
    end
    return growth_list
end


begin
    n=20
    x = collect(1:n)
    plot(x, deg_test(n), title="growth function for n = $n\$")
    xlabel!("degree (i)")
    ylabel!("g(i)")
end
