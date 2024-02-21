include("genMat.jl")


n = 15
X = gen_X(n)
Y = gen_Y(n)

U = gen_X_upper_triangular(n)
 

begin
    monomials = gen_monomials(X, Y, n)  # Adjust degree as needed
    is_independent = check_linear_independence(monomials)
    println("Are the generated monomials linearly independent? ", is_independent)
end


begin
    monomials = gen_monomials(X, U, n)  # Adjust degree as needed
    is_independent = check_linear_independence(monomials)
    println("Are the generated monomials linearly independent? ", is_independent)
end


begin
    monomials = gen_monomials(X, L, n)  # Adjust degree as needed
    is_independent = check_linear_independence(monomials)
    println("Are the generated monomials linearly independent? ", is_independent)
end


begin
    monomials = gen_monomials(U, Y, n)  # Adjust degree as needed
    is_independent = check_linear_independence(monomials)
    println("Are the generated monomials linearly independent? ", is_independent)
end


begin
    monomials = gen_monomials(L, Y, n)  # Adjust degree as needed
    is_independent = check_linear_independence(monomials)
    println("Are the generated monomials linearly independent? ", is_independent)
end


begin
    monomials = gen_monomials(L, X, n)  # Adjust degree as needed
    is_independent = check_linear_independence(monomials)
    println("Are the generated monomials linearly independent? ", is_independent)
end


begin
    monomials = gen_monomials(L, U, n)  # Adjust degree as needed
    is_independent = check_linear_independence(monomials)
    println("Are the generated monomials linearly independent? ", is_independent)
end

U*L - L*U

U*L*U

U

function deg_test(n)
    U = gen_X_upper_triangular(n)
    L = gen_Y_lower_triangular(n)
    dimVprev = 0
    growth_list = []
    monomials = Set([Matrix{Float64}(undef, n, n)])
    # matrix_stack = flatten_matrices(monomials)
    dimVnew = 0
    growth = dimVnew- dimVprev
    push!(growth_list, growth)
    dimVprev = dimVnew
    for deg = 1:n-1
        push!(monomials,I(n))
        temp = []
        for term in monomials
            push!(temp, term*L)
            push!(temp, L*term)
            push!(temp, term*U)
            push!(temp, U*term)
        end
        union!(monomials, temp)
        display_monomials(monomials)
        # display_monomials(monomials)
        matrix_stack = flatten_matrices(monomials)
        dimVnew = rank(matrix_stack, atol=1e-20)
        growth = dimVnew- dimVprev
        push!(growth_list, growth)
        dimVprev = dimVnew
    end
    println("Final dim = ", dimVnew)
    println(growth_list)
    return growth_list
end

deg_test(10