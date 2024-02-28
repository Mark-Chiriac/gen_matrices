using LinearAlgebra
using SparseArrays
using Plots
include("genMat.jl")

function deg_test(X, Y, n)
    dimVprev = 0
    growth_list = []
    monomials = Set([Matrix(1.0I, n, n)])
    matrix_stack = flatten_matrices(monomials)
    dimVnew = rank(matrix_stack, atol=1e-15)
    growth = dimVnew- dimVprev
    push!(growth_list, growth)
    dimVprev = dimVnew
    for deg = 1:3n-1
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

n=8
udiag = gen_udiag(n)
ldiag = gen_ldiag(n)
u_l_diag = deg_test(udiag, ldiag, n)
cyclic = gen_cyclic(n)
# diag_uniq = gen_diag_uniq(n)
# cyclic_diag_uniq = deg_test(cyclic, diag_uniq, n)
# sing_entry = gen_sing_entry(n)
# cyclic_sing_entry = deg_test(cyclic, sing_entry, n)
v = gen_vandermonde(n)
cyclic_v = deg_test(cyclic, v, n)
# u_v = deg_test(cyclic, v, n)
# l_v = deg_test(cyclic, v, n)

plot(collect(1:3n), [u_l_diag, cyclic_v], labels=["UL" "CV"])
xlabel!("degree")
ylabel!("growth")
savefig("growth.png")

plot(collect(1:3n), [cumsum(u_l_diag),cumsum(cyclic_v)], labels=["UL" "CV"])
xlabel!("degree")
ylabel!("span")
savefig("span.png")