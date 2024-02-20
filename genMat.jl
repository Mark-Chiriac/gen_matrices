using LinearAlgebra
using SparseArrays
function display_monomials(monomials)
    for mon in monomials
        display(mon)
    end
end
function flatten_matrices(matrices::Vector{<:Any})
    return hcat([vec(matrix) for matrix in matrices]...)
end

function gen_X(n)
    X = zeros(n,n)
    for i in 1:n
        j = mod(i, n) + 1  #column index for the cyclic shift
        X[i, j] = 1
    end
    return X
end

function gen_Y(n)
    X = zeros(n,n)
    for i in 1:n
        X[i, i] = i
    end
    return X
end
# gen_Y(n) = spdiagm(0 => 1:n)

function gen_monomials(X_, Y_, d)
    monomials = []
    for i in 0:d-1
        for j in 0:d-1
            push!(monomials, X_^i * Y_^j)
        end
    end
    return monomials
end

function check_linear_independence(monomials)
    # Convert  matrix in the list to a flattened vector and stack them horizontally
    matrix_stack = flatten_matrices(monomials)
    # print(size(matrix_stack))
    # rank = rank(matrix_stack)
    # Check linear independence by comparing the rank to the number of matrices
    is_independent = rank(matrix_stack, atol=1e-10) == length(monomials)
    println(rank(matrix_stack, atol=1e-10))
    println(length(monomials))
    # println("Rank=" ,rank)
    return is_independent
end


begin
    n = 15 # Example for a 3x3 matrix, can be any positive integer
    # Generate matrices
    X = gen_X(n)
    Y = gen_Y(n)
    # Generate monomials
    monomials = gen_monomials(X, Y, n)  # Adjust degree as needed
    # size(monomials)
    is_independent = check_linear_independence(monomials)
    println("Are the generated monomials linearly independent? ", is_independent)
end
# Check linear independence



