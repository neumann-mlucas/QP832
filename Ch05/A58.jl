using Plots
using CSV

include("./simplex.jl")

function mse(v1,v2)
    @assert length(v1) == length(v2)
    @. return (v1 - v2) ^ 2
end

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

function computef(v)

    time = 100
    A0 = 10
    B0 = 0.1
    k1 = v[1]; k2 = v[2]
    A_sim = reaction_kinetics(A0,B0,time,0.01,k1,k2)

    data = CSV.read("data_exp.csv")
    A_exp = data[:,1]

    error = mse(A_sim, A_exp)
    cum_error = cumsum(error)

    return cum_error[1000]
end

xinit = rand(3,2)
print(size(xinit))
ks, f = simplex(computef,xinit,100)
