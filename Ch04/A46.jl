# Solução para A46, A47, A48, A49, A50, A51, A52, A53, A54
# 46) Usar func_46 and init_46
# 47) Usar func_47 and init_47
# 48) Usar func_47 and init_48
# 49) Time step variável implementada -- ver linhas 62-64
# 50) Entendi
# 51) Ver 54
# 52) Usei
# 53) Ver 54
# 54) implementado, ver linhas 52-54
using Statistics


func_46(v) =  abs(v[1] .^ 2 .+ sin(v[2]))
func_47(v) = sum(v .^ 2)

function linear_search(f, xtrial, xbad)
    @assert size(xtrial) == size(xbad)
    xtemp = zeros(size(xtrial))
    ftemp = 0.0
    for i in 1:100
        @. xtemp = xbad + rand() * (xtrial - xbad)
        ftemp = f(xtemp)
        if ftemp < f(xbad)
            break
        end
    end
    return ftemp, xtemp
end


function simplex(f,vinit,niter,convcrit=1.e-10)

    @assert size(vinit) == (3,3)
    # Copy vinit to x and apply f
    x  = map(x -> x, vinit)
    fx = mapslices(f, vinit, dims=2)
    # Print
    println(" Initial points: ")
    for i in 1:3
        println(x[i,:]," ",fx[i])
    end
    # Init variables
    xtrial = zeros(1,3)
    xtemp = zeros(1,3)
    ftemp = 0.

    # Main interation
    for iter in 1:niter

        println("\nITERATION: ", iter)
        # Sorting the Vector (A54's code does not work for my inputs)
        order = sort([1; 2; 3], by=i->fx[i])
        x = x[order,:]; fx = fx[order]
        # Check convergence
        if all((fx[end] .- fx) .< convcrit)
            println("-Precision reached. ")
            println("-Best point found: ", x[1,:], " f = ", fx[1])
            break
        end

        # Compute averge of best points and trial point
        println("-Calculating Xavg and Xtrial.")
        xbad = transpose(x[end,:])
        fbad = f(xbad)
        xavg = mean(x[1:2,:],dims=1)
        # Variable "timestep" -- A49
        fbad > 10 ? ts = log(fbad) : ts = 1
        fbad < 0.1 ? ts = 10 * fbad : ts = 1
        # If ftrial is better than f(xbad), replace 3rd point with trial point
        xtrial = xbad .+ 4 .* ts .* (xavg .- xbad)
        ftrial = f(xtrial)
        if ftrial < fx[end]
            fx[end] = ftrial
            x[end,:] = xtrial
            println("--Accepted AVG point: ", x[end,:]," f = ", fx[end])
        else
            println("--Function increased. Trying line search. ")
            # Try up to 100 different points
            ftemp, xtemp = linear_search(f, xtrial, xbad)
            # If the line search didn't find a better point, stop
            if ftemp > fx[end]
                println("---Failed Linear Search")
                break
            else
                fx[end] = ftemp
                x[end,:] = xtemp
                println("---Linear search accepted point: ", x[end,:]," f = ", fx[end])
            end
        end
        # Maximum number of trials
        if iter == niter
            println("-Maximum number of trials reached. ")
        end
    end
    println("\nBEST POINT FOUND: ", x[1,:], " f = ", fx[1])
    return x[1,:], fx[1]
end

init_46 = hcat(10 .* rand(3,2), zeros(3,1))
init_47 = 10 .* rand(3,3)
init_48 = rand(3,3)
x = simplex(func_47,init_48,1000)
