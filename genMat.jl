using LinearAlgebra
using SparseArrays
function display_monomials(monomials)
    for mon in monomials
        display(mon)
    end
end
function flatten_matrices(matrices::Any)
    return hcat([vec(matrix) for matrix in matrices]...)
end

function gen_cyclic(n)
    X = zeros(n,n)
    for i in 1:n
        j = mod(i, n) + 1  #column index for the cyclic shift
        X[i, j] = 1
    end
    return X
end


function gen_rprime(n)
    X = zeros(n,n)
    for i in 1:n
        j = mod(i+3, n) + 1  #column index for the cyclic shift
        X[i, j] = 1
    end
    return X
end


function gen_sing_entry(n)
    X = zeros(n,n)
    X[1,1] = 1
    return X
end

function gen_upper_diag(n)
    X = zeros(n,n)
    for i in 1:n-1
        X[i, i+1] = 1
    end
    return X
end


function gen_vandermonde(n)
    X = zeros(n,n)
    for i in 1:n
        for j in 1:n
            X[i, j] = i^j
        end
    end
    return X
end

function gen_diag_uniq(n)
    X = zeros(n,n)
    for i in 1:n
        X[i, i] = i
    end
    return X
end

function gen_diag(n)
    X = zeros(n,n)
    for i in 1:n
        X[i, i] = 1
    end
    return X
end
# gen_Y(n) = spdiagm(0 => 1:n)

function gen_udiag(n)
    X = zeros(n,n)
    for i in 1:n-1
        X[i, i+1] = 1
    end
    return X
end
function gen_ldiag(n)
    X = zeros(n,n)
    for i in 1:n-1
        X[i+1, i] = 1
    end
    return X
end

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
    
    is_independent = rank(matrix_stack, atol=1e-10) == length(monomials)
    println(rank(matrix_stack, atol=1e-10))
    println(length(monomials))

    return is_independent
end


# begin
#     n = 15 
#     # Generate matrices
#     X = gen_X(n)
#     Y = gen_Y(n)
#     # Generate monomials
#     monomials = gen_monomials(X, Y, n)  # Adjust degree as needed
#     is_independent = check_linear_independence(monomials)
#     println("Are the generated monomials linearly independent? ", is_independent)
# end



