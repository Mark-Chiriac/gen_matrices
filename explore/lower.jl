using LinearAlgebra
using SparseArrays



# Updated function with correct identity matrix generation
function gen_monomials_and_check_span(X::SparseMatrixCSC, Y::SparseMatrixCSC, n::Int)
    monomials = []
    for d in 1:n^2
        for i in 0:d
            for j in 0:(d-i)
                if i+j <= d
                    push!(monomials, X^i * Y^j)
                end
            end
        end
        flattened = flatten_matrices(monomials)
        if rank(flattened) == n^2
            return d
        end
    end
    return n^2  # Fallback if something goes wrong
end

function flatten_matrices(matrices::Vector{<:Any})
    return hcat([vec(matrix) for matrix in matrices]...)
end

# # Main function to find delta_n remains unchanged
# function find_delta_n(n::Int)
#     X = gen_X(n)
#     Y = gen_Y(n)
#     delta_n = gen_monomials_and_check_span(X, Y, n)
#     return delta_n
# end


function find_delta_n(n::Int)
    X = gen_X(n)
    Y = gen_Y(n)
    delta_n = gen_monomials_and_check_span(X, Y, n)
    return delta_n
end

find_delta_n(8)