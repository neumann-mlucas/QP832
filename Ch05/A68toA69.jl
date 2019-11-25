# Solução para A68 e A69
# Printa a otimzação para ambos os exercícios
using Optim
using CSV


f(x) = x[1] ^ 2 + (x[2] - 3.) ^ 2

function reaction_kinetics(A0, B0, nsteps=1000, dt=0.01, k1=0.1, k2=0.02)
    A = Vector{Float64}(undef,nsteps); A[1] = A0
    B = Vector{Float64}(undef,nsteps); B[1] = B0
    for ts in 1:(nsteps -1)
        A[ts+1] = A[ts] - k1 * dt * A[ts] + k2 * dt * B[ts]
        B[ts+1] = B[ts] + k1 * dt * A[ts] - k2 * dt * B[ts]
        if A[ts+1] < 1.e-6
            A[ts+1] = 0.
        elseif B[ts+1] < 1.e-6
            B[ts+1] = 0.
        end
    end
    return A
end


function mse(v1,v2)
    @assert length(v1) == length(v2)
    @. return (v1 - v2) ^ 2
end


function computdef(v)
    data = CSV.read("data_55.csv")[:,1]
    k1, k2 = v[1], v[2]
    cum_error = reaction_kinetics(10,0.1,1000,0.1,k1,k2) |> (x->mse(x,data)) |> cumsum
    return cum_error[end]
end


xinit = rand(2)
x = optimize(f, xinit,NelderMead())
println("f opt = $x")
x = optimize(computdef, xinit, NelderMead())
println("comutdef opt = $x")
