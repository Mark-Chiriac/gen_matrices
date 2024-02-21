using LinearAlgebra, SparseArrays
function display_monomials(monomials)
    for mon in monomials
        display(mon)
    end
end
function flatten_matrices(matrices)
    return hcat([vec(matrix) for matrix in matrices]...)
end

# Generates an upper triangular matrix with random entries
function gen_X_upper_triangular(n)
    U = zeros(n,n)
    val = 1
    for i=2:n
        for j in 1:i-1
            U[j,i] = val
            val+=1
        end
    end
    return U
end
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
    
    is_independent = rank(matrix_stack, atol=1e-20) == length(monomials)
    println(rank(matrix_stack, atol=1e-20))
    println(length(monomials))

    return is_independent
end


# begin
#     n = 20 
#     # Generate matrices
#     X = gen_X(n)
#     Y = gen_Y(n)
#     # Generate monomials
#     monomials = gen_monomials(X, Y, n)  # Adjust degree as needed
#     is_independent = check_linear_independence(monomials)
#     println("Are the generated monomials linearly independent? ", is_independent)
# end

# Y = gen_X_upper_triangular(10)

# n=10

# n=10
# d = collect(1:n)
# du = collect(1:n-1)
# tridiag = Tridiagonal(du, d, du)
# gen_X(10)^4*tridiag