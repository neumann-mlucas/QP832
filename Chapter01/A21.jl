# Solução para A23, A24, A25
function reaction_kinetics(AO, BO, time, dt=0.1, k1=0.1, k2=0.02)
    nsteps = Int64(time/dt)
    T = collect(range(0, length=nsteps, step=Float64(dt)))
    A = Vector{Float64}(undef,nsteps); A[1] = AO
    B = Vector{Float64}(undef,nsteps); B[1] = BO
    for ts in 1:(nsteps -1)
        A[ts+1] = A[ts] - k1 * dt * A[ts] + k2 * dt * B[ts]
        B[ts+1] = B[ts] + k1 * dt * A[ts] - k2 * dt * B[ts]
        error = abs((AO + BO - A[ts]) - B[ts+1])
        if A[ts+1] < 1.e-6
            A[ts+1] = 0.
        elseif B[ts+1] < 1.e-6
            B[ts+1] = 0.
        end
        if ts == (nsteps -1) || error > 1.e-4
            println("with dt= $dt, k1= $k1, k2= $k2, at timestep = $(ts+1)")
            println("Error in B is $error\n")
        end
    end
    return T, A, B
end

t_lim = 100
dt = 0.1
t = Vector{Float64}(undef,Int64(t_lim/dt))
a = Vector{Float64}(undef,Int64(t_lim/dt))
b = Vector{Float64}(undef,Int64(t_lim/dt))

t, a, b = reaction_kinetics(100,0,100,0.1,0.1,0.1)
t, a, b = reaction_kinetics(100,0,100,0.1,0.001,0.1)
t, a, b = reaction_kinetics(100,0,100,0.1,0.1,0.001)
t, a, b = reaction_kinetics(100,0,1000,1.,0.1,0.1)
t, a, b = reaction_kinetics(100,0,1000,1.,0.001,0.001)

