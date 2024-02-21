using LinearAlgebra
using SparseArrays
using Random


# Generates a random matrix
function gen_X_random(n)
    return randn(n, n)  # Random matrix with standard normal distribution
end

# Generates a permutation matrix
function gen_Y_permutation(n)
    I = Matrix{Float64}(I, n, n)  # Identity matrix
    return I[:, randperm(n)]  # Permutation of columns
end

# Generates an upper triangular matrix with random entries
function gen_X_upper_triangular(n)
    return triu(randn(n, n), 1)  # Upper triangular, excluding diagonal
end

# Generates a lower triangular matrix with incrementing entries
function gen_Y_lower_triangular(n)
    L = zeros(n, n)
    val = 1
    for i in 2:n
        for j in 1:i-1
            L[i, j] = val
            val += 1
        end
    end
    return L
end

Y = gen_Y_lower_triangular(10)
include("genMat.jl")
X = gen_X(10)
Y*X^6