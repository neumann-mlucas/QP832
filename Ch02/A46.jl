using Statistics

function f(v)
    @. return v[:,1] ^ 2 + sin(v[:,2])
end

function simplex(f,xinit,niter)

    @assert size(xinit) == (3,2)

    # Copy xinit and apply f
    x  = map(x -> x, xinit)
    fx = f(x)
    # Check
    for i in 1:3
        println(x[i]," ",fx[i])
    end
    # Init variables
    xtemp = zeros(2)
    ftemp = 0.
    xav = zeros(2)
    xtrial = zeros(2)
    println(" Initial points: ")
    # Convergence criterium desired
    convcrit = 1.e-10

    # Main interation
    for iter in 1:niter
        println(" ------ ITERATION: ", iter)
        # Better way to Sort a Vector
        sv = hcat(x, fx)
        sv = sv[sortperm(sv[:,3]),:]
        x  = sv[:,1:2]
        fx = f(x)
        # Check convergence
        #= if (fx[3]-fx[2] < convcrit) && (fx[3]-fx[1] < convcrit) =#
        if all((fx[3] .- fx) .< convcrit)
            println(" Precision reached. ")
            println(" Best point found: ", x[1,:], " f = ", fx[1])
            return x[1,:], fx[1]
        end
        # Compute averge of best points
        xav = mean(x[1:2,:],dims=1)[:]
        # Compute trial point
        @. xtrial = x[3,:] + 2 * (xav - x[3,:])
        ftrial = f(transpose(xtrial))[1]
        # If ftrial is better than fx[3], replace point 3 with trial point
        if ftrial < fx[3]
            fx[3] = ftrial
            x[3,:] = xtrial
            println(" Accepted point: ", x[3,:]," f = ", fx[3,:])
        else
            println(" Function increased. Trying line search. ")
            # Try up to 10 different points
            for j in 1:10
                @. xtemp = x[3,:] + rand() * (xtrial - x[3,:])
                ftemp = f(transpose(xtemp))[1]
                if ftemp < fx[3]
                    fx[3] = ftemp
                    x[3,:] = xtemp
                    println("   Line search succeeded at trial ", j)
                    println("   New point: ", x[3], " f = ", fx[3])
                    break # exits from line search loop
                end
            end
            # If the line search didn't find a better point, stop
            if ftemp > fx[3]
                println(" End of search. ")
                println(" Best point found: ", x[1,:], " f = ", fx[1])
                return x[1,:], fx[1]
                end
            end
        end
    println(" Maximum number of trials reached. ")
    println(" Best point found: ", x[1,:], " f = ", fx[1])
    return x[1,:], fx[1]
end

init = 10 .* rand(3,2)
x = simplex(f,init,100)
print(x)
