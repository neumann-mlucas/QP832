# Solução para A64, A65, A66 e A67
# 64) Definido Data
# 65) Data é um parametro das funções
# 66) Sem váriaveis globais
# 67) Da erro
using CSV
include("./simplex_66.jl")


function mse(v1,v2)
    @assert length(v1) == length(v2)
    @. return (v1 - v2) ^ 2
end


function reaction_kinetics(data, k1=0.1, k2=0.02)
    A = Vector{Float64}(undef,data.nsteps); A[1] = data.A0
    B = Vector{Float64}(undef,data.nsteps); B[1] = data.B0
    for ts in 1:(data.nsteps -1)
        A[ts+1] = A[ts] - k1 * data.dt * A[ts] + k2 * data.dt * B[ts]
        B[ts+1] = B[ts] + k1 * data.dt * A[ts] - k2 * data.dt * B[ts]
        if A[ts+1] < 1.e-6
            A[ts+1] = 0.
        elseif B[ts+1] < 1.e-6
            B[ts+1] = 0.
        end
    end
    return A
end


function computdef(v,data)
    k1, k2 = v[1], v[2]
    cum_error = reaction_kinetics(data,k1,k2) |> (x->mse(x,data.A_exp)) |> cumsum
    return cum_error[end]
end


struct Data
    A0 :: Float64
    B0 :: Float64
    dt :: Float64
    nsteps :: Int64
    A_exp :: Vector{Float64}
end


Aexp = CSV.read("data_55.csv")[:,1]
data = Data(10.0,0.1,0.01,1000,Aexp)
xinit = rand(3,3)
ks, f = simplex(computdef,xinit,data,100)
