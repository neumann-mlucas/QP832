using Statistics


function linear_search(f, xtrial, xbad,data)
    @assert size(xtrial) == size(xbad)
    xtemp = zeros(size(xtrial))
    ftemp = 0.0
    fbad = f(xbad,data)
    for i in 1:100
        @. xtemp = xbad + rand() * (xtrial - xbad)
        ftemp = f(xtemp,data)
        if ftemp < fbad
            break
        end
    end
    return ftemp, xtemp
end


function simplex(f,vinit,data,niter,convcrit=1.e-10)

    @assert size(vinit) == (3,3)
    # Copy vinit to x and apply f
    x  = map(x -> x, vinit)
    fx = mapslices((x->f(x,data)), vinit, dims=2)
    # Init variables
    xtrial = zeros(1,3)
    xtemp = zeros(1,3)
    ftemp = 0.

    # Main interation
    for iter in 1:niter
        order = sort([1; 2; 3], by=i->fx[i])
        x = x[order,:]; fx = fx[order]
        # Check convergence
        if all((fx[end] .- fx) .< convcrit)
            break
        end
        # Compute averge of best points and trial point
        xbad = transpose(x[end,:])
        fbad = f(xbad,data)
        xavg = mean(x[1:2,:],dims=1)
        # Variable "timestep" -- A49
        fbad > 10 ? ts = log(fbad) : ts = 1
        fbad < 0.1 ? ts = 10 * fbad : ts = 1
        # If ftrial is better than f(xbad,data), replace 3rd point with trial point
        xtrial = xbad .+ 4 .* ts .* (xavg .- xbad)
        ftrial = f(xtrial,data)
        if ftrial < fx[end]
            fx[end] = ftrial
            x[end,:] = xtrial
        else
            # Try linear search
            ftemp, xtemp = linear_search(f, xtrial, xbad, data)
            if ftemp > fx[end]
                break
            else
                fx[end] = ftemp
                x[end,:] = xtemp
            end
        end
    end
    println("\nBEST POINT FOUND: ", x[1,:], " f = ", fx[1])
    return x[1,:], fx[1]
end
