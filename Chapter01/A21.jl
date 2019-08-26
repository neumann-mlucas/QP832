# Solução para A21, A22, A23, A24, A25
# 21) reaction_kinetics discretiza a equação
# 22) pode ser plotado com os valores de retorno da reaction_kinetics
# 23) discretização de B está implementada em reaction_kinetics
# 24) error para o balanço de massas e da forma exata da equação são calculados pela função
# 25) clausula "if ..." indica o erro quando esse é maior que 1.0e-4
function exact_sol(AO, BO, ts, dt=0.1, k1=0.1, k2=0.02)
    time = ts * dt
    A = AO * ((k2 + k1 * exp(-(k1+k2) * time))/(k1+k2))
    B = (AO + BO) - A
    return B
end

function reaction_kinetics(AO, BO, time, dt=0.1, k1=0.1, k2=0.02)
    nsteps = Int64(time/dt)
    T = collect(range(0, length=nsteps, step=Float64(dt)))
    A = Vector{Float64}(undef,nsteps); A[1] = AO
    B = Vector{Float64}(undef,nsteps); B[1] = BO
    for ts in 1:(nsteps -1)
        A[ts+1] = A[ts] - k1 * dt * A[ts] + k2 * dt * B[ts]
        B[ts+1] = B[ts] + k1 * dt * A[ts] - k2 * dt * B[ts]
        error_mass = abs((AO + BO - A[ts]) - B[ts+1])
        error_exct = abs(exact_sol(AO,BO,ts,dt,k1,k2) - B[ts])
        if A[ts+1] < 1.e-6
            A[ts+1] = 0.
        elseif B[ts+1] < 1.e-6
            B[ts+1] = 0.
        end
        if ts == (nsteps -1) || error_exct > 1.e-4
            println("with dt= $dt, k1= $k1, k2= $k2, at timestep = $(ts+1)")
            println("Error in B is $error_exct\n")
        end
    end
    return T, A, B
end


t_lim = 100
dt = 0.1

t = Vector{Float64}(undef,Int64(t_lim/dt))
a = Vector{Float64}(undef,Int64(t_lim/dt))
b = Vector{Float64}(undef,Int64(t_lim/dt))

reaction_kinetics(100,0,100,0.1,0.1,0.1)
reaction_kinetics(100,0,100,1.,0.1,0.1)
reaction_kinetics(100,0,100,0.1,0.001,0.1)
reaction_kinetics(100,0,100,0.1,0.1,0.001)
