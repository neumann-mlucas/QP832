# Solução para A56 e A57
# 56) Programa lê o arquivo data_55.csv
# 47) Programa printa o MSD para os dois casos
using CSV


function mse(v1,v2)
    @assert length(v1) == length(v2)
    @. return (v1 - v2) ^ 2
end


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


data = CSV.read("data_55.csv")[:,1]

A0 = 10
B0 = 0.1
cum_error = reaction_kinetics(A0,B0) |> (x->mse(x,data)) |> cumsum
println("k1 = 0.1, k2 = 0.02")
println("Cum errer = $(cum_error[end])\n")

cum_error = reaction_kinetics(A0,B0,1000,0.01,0.8,0.28) |> (x->mse(x,data)) |> cumsum
println("k1 = 0.8, k2 = 0.28")
println("Cum errer = $(cum_error[end])\n")
