
function whenF(j)

    for n =1:j # Example for a 3x3 matrix, can be any positive integer
    # Generate matrices
        X = gen_X(n)
        Y = gen_Y(n)
        # Generate monomials
        monomials = gen_monomials(X, Y, n)
        is_independent = check_linear_independence(monomials)
        if is_independent == false
            println(n)
        end
    end
    return
end

function gram_schmidt(a; tol = 1e-10)
    q = []
    for i = 1:length(a)
        qtilde = a[i]
        for j = 1:i-1
            qtilde -= (q[j]'*a[i]) * q[j]
        end
        if norm(qtilde) < tol
            println("Vectors are linearly dependent.")
            return true
        end
        push!(q, qtilde/norm(qtilde))
    end
    return q
end
