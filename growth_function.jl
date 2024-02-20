using LinearAlgebra
using SparseArrays
using Plots
include("genMat.jl")

function deg_test(n)
    X = gen_X(n)
    Y = gen_Y(n)
    dimVprev = 0
    growth_list = []
    monomials = Set([Matrix(1.0I, n, n)])
    matrix_stack = flatten_matrices(monomials)
    dimVnew = rank(matrix_stack, atol=1e-10)
    growth = dimVnew- dimVprev
    push!(growth_list, growth)
    dimVprev = dimVnew
    for deg = 1:n-1
        temp = []
        for term in monomials
            push!(temp, term*X)
            push!(temp, X*term)
            push!(temp, term*Y)
            push!(temp, Y*term)
        end
        union!(monomials, temp)
        matrix_stack = flatten_matrices(monomials)
        dimVnew = rank(matrix_stack, atol=1e-10)
        growth = dimVnew- dimVprev
        push!(growth_list, growth)
        dimVprev = dimVnew
    end
    return growth_list
end



n=20
x = collect(1:n)
plot(x, deg_test(n), title="growth function for n = $n\$")
xlabel!("degree (i)")
ylabel!("g(i)")
savefig('output.png')
