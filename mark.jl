include("genMat.jl")
using Plots
function filter_matrices(matrices::Set{Matrix{Float64}})
    filtered_matrices = Set{Matrix{Float64}}()

    for matrix in matrices
        if any(element -> element >= 1e-10, matrix)
            push!(filtered_matrices, matrix)
        end
    end

    return filtered_matrices
end

function deg_test(n)
    X = gen_X(n)
    Y = gen_Y(n)
    growth_list = []
    # create set with X and Y initially
    monomials = Set([Matrix{Float64}(undef, n, n)])
    push!(monomials, I(n))
    dim0 = 1 # raised to the zero power is Identity
    push!(growth_list, dim0)
    push!(monomials, X, Y) # only matrices in one power
    dimV1 = 3
    push!(growth_list, dimV1-dim0)
    dimVprev = dimV1
    # increase the degree
    for deg = 1:n-1
        temp = []
        for term in monomials
            push!(temp, term*X)
            push!(temp, X*term)
            push!(temp, term*Y)
            push!(temp, Y*term)
        end
        # println("TEMP:")
        # println()
        # display_monomials(temp)
        union!(monomials, temp)
        monomials = filter_matrices(monomials)
        degree = deg +1
        # println("SET MONS for degree $degree \$:")
        # display_monomials(monomials)
        matrix_stack = flatten_matrices(monomials)
        dimVnew = rank(matrix_stack, atol=1e-5)
        # dimVnew = rank(matrix_stack)
        growth = dimVnew- dimVprev
        push!(growth_list, growth)
        dimVprev = dimVnew
    end
    println("Final dim = ", dimVprev)
    println("Growth list = ", growth_list)
    return growth_list
end
deg_test(4)

function remove_invalid_matrices!(matrices::Set{Matrix{Float64}})
    # Collect matrices that should be removed
    to_remove = Set{Matrix{Float64}}()

    for matrix in matrices
        # Check if the matrix has any element less than 1e-10
        if any(element -> element < 1e-30, matrix)
            push!(to_remove, matrix)
        end
        if any(element -> element > 1e30, matrix)
            push!(to_remove, matrix)
        end
    end

    # Remove the collected matrices from the original set
    for matrix in to_remove
        delete!(matrices, matrix)
    end
end

# deg_test(10)

function growth_plot(n)
    plot()
    title!("Growth function for various sizes (n)")
    xlabel!("Degree (i)")
    ylabel!("Growth Function (g(i))")
    for i=3:n
        x = collect(1:i+1)
        growth = deg_test(i)
        plot!(x, growth, label="n = $i")  # Correct use of label interpolation
    end
    savefig("output.png")
end

growth_plot(13)