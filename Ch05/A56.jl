using Plots
using CSV

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

time = 100
A0 = 10
B0 = 0.1

data = CSV.read("data_exp.csv")
x = data[:,1]
y = reaction_kinetics(A0,B0,time)
error = mse(x,y)
cum_error = cumsum(error)
