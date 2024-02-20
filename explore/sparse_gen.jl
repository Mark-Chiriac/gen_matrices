"""
    THE RANK OF SparseArrays IS NOT EASILY DONE WITH JULIA BUT THERE ARE DIRECTIONS TO LOOK INTO
"""
using LinearAlgebra, SparseArrays, Arpack
include("genMat.jl")

gen_Y(n) = spdiagm(0 => 1:n)

function gen_X(n)
    S = spdiagm(1 => ones(n-1))
    S[n,1] = 1
    return S
end


n = 15
# Generate matrices
X = gen_X(n)
Y = gen_Y(n)
# Generate monomials
monomials = gen_monomials(X, Y, n)
# Check independence
is_independent = check_linear_independence(monomials)
println("Are the generated monomials linearly independent? ", is_independent)

