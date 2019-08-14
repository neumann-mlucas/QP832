# Solução para A16, A17, A18, A19
function reaction_kinetics(AO, BO, time, dt=0.1, k1=0.1)
    nsteps = Int64(time/dt)
    T = collect(range(0, length=nsteps, step=Float64(dt)))
    A = Vector{Float64}(undef,nsteps); A[1] = AO
    B = Vector{Float64}(undef,nsteps); B[1] = BO
    for ts in 1:(nsteps -1)
        A[ts+1] = A[ts] - k1 * dt * A[ts]
        B[ts+1] = B[ts] + k1 * dt * A[ts]
        if A[ts+1] < 1.e-6
            A[ts+1] = 0.
        elseif B[ts+1] < 1.e-6
            B[ts+1] = 0.
        end
    end
    return T, A, B
end


t_lim = 1000
dt = 0.01

t = Vector{Float64}(undef,Int64(t_lim/dt))
a = Vector{Float64}(undef,Int64(t_lim/dt))
b = Vector{Float64}(undef,Int64(t_lim/dt))
t, a, b = reaction_kinetics(100,0,t_lim,dt)
