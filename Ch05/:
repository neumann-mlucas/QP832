using Plots
using CSV

include("./simplex_66.jl")

function reaction_kinetics(AO, BO, time, dt=0.01, k1=0.1, k2=0.02)
    nsteps = Int64(time/dt)
    T = collect(range(0, length=nsteps, step=Float64(dt)))
    A = Vector{Float64}(undef,nsteps); A[1] = AO
    B = Vector{Float64}(undef,nsteps); B[1] = BO
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

function computef(v, Data)

    k1 = v[1]; k2 = v[2]

    A_sim = reaction_kinetics(data.A0,data.B0,data.time,0.01,k1,k2)
    A_exp = data.A_exp

    error = mse(A_sim, A_exp)
    cum_error = cumsum(error)

    return cum_error[end]
end

struct Data
    A0 :: Float64
    B0 :: Float64
    time :: Int64
    A_exp :: Vector{Float64}
end

Aexp = CSV.read("data_exp.csv")
data = Data(10.0,0.1,100,Aexp[:,1])

xinit = rand(3,2)
ks, f = simplex(computef,xinit,100,data)
