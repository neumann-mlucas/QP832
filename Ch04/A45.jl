# Solução para A45
# Xtry é modificado proporcinalmente ao valor de f(Xbest)
# Comparar resultados com plot(r1) & plot(r2)
using Plots

# Function to be minimized
input_f(x) = sum(x .^ 2)

# Minimizer by random search
function random_1(f,p_init, ntrials,dt)
    xbest = xtry = p_init
    fbest = f(p_init)
    for i in 1:ntrials
        xtry = xbest .+ 1.e-2 .* (-1.0 .+ 2.0 .* rand(2))
        fx = f(xtry)
        if fx < fbest
        fbest = fx
        xbest = xtry
        end
    end
    println("  With random_1, best point found was f = ", fbest)
    return fbest
end

# Minimizer by random search with variable step
function random_2(f,p_init,ntrials,dt)
    xbest = xtry = p_init
    fbest = f(xbest)
    for i in 1:ntrials
        guess = -1.0 .+ 2.0 .* rand(2)
        fbest > 1 ? k = dt .* fbest : k = dt .* 0.1
        xtry = xbest .+ k .* guess
        fx = f(xtry)
        if fx < fbest
        fbest = fx
        xbest = xtry
        end
    end
    println("  With random_2, best point found was f = ", fbest)
    return fbest
end


r1 = Vector{Float64}(undef,1000)
r2 = Vector{Float64}(undef,1000)
dt = 1.e-1
for (idx, n) in enumerate(1:10:10000)
    p = rand(-10:10,2)
    println(" N steps = $n  and init = $p")
    r1[idx] = random_1(input_f,p,n,dt)
    r2[idx] = random_2(input_f,p,n,dt)
end
