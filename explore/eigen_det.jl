using LinearAlgebra
using SparseArrays
using Arpack
function display_monomials(monomials)
    for mon in monomials
        display(mon)
    end
end


function gen_X(n)
    X = spzeros(n, n)
    for i in 1:n
        j = mod(i, n) + 1  #column index for the cyclic shift
        X[i, j] = 1
    end
    return X
end

gen_Y(n) = spdiagm(0 => 1:n)

function gen_monomials(X_, Y_, d)
    monomials = []
    for i in 0:d-1
        for j in 0:d-1
            push!(monomials, X_^i * Y_^j)
        end
    end
    return monomials
end

function calculate_determinants(monomials)
    determinants = []
    for monomial in monomials
        push!(determinants, det(monomial))
    end
    return determinants
end

function calculate_eigen(monomials)
    eigenvalues_vectors = Dict()
    for (index, monomial) in enumerate(monomials)
        if issparse(monomial)
            # For sparse matrices, use eigs from Arpack
            # Note: eigs might return only a subset of eigenvalues/eigenvectors
            vals, vecs = eigs(monomial)
        else
            # For dense matrices, use the standard eigen function
            eigen_decomp = eigen(monomial)
            vals, vecs = eigen_decomp.values, eigen_decomp.vectors
        end
        eigenvalues_vectors[index] = (vals, vecs)
    end
    return eigenvalues_vectors
end

begin
    n = 4 # Example for a 3x3 matrix, can be any positive integer
    # Generate matrices
    X = gen_X(n)
    Y = gen_Y(n)
    monomials = gen_monomials(X, Y, n)  # Adjust degree as needed
end

begin
    determinants = calculate_determinants(monomials)
end

function evaluate_eigenvalues_monomials(monomials_list)
    for (index, (vals, vecs)) in calculate_eigen(monomials_list)
        println("Monomial $index:")
        println("Eigenvalues: ", vals)
        println("Eigenvectors: ")
        for vec in eachcol(vecs)
            println(vec)
        end
        println() # For better readability
    end
end

evaluate_eigenvalues_monomials(monomials)