# Solução para A21, A22, A23, A24, A25
# 21) reaction_kinetics discretiza a equação
# 22) Gráfico pode ser obtido com plot(a);plot!(b)
# 23) Função retorn [B] que pode ser poltado com plot(b)
# 24) Erro para o balanço de massas e da forma exata da equação são calculados na função
# 25) Clausula "if ..." indica o erro quando esse é maior que 1.0e-8
function exact_sol(AO, BO, ts, dt=0.1, k1=0.1, k2=0.1)
    time = ts * dt
    A = AO * ((k2 + k1 * exp(-(k1+k2) * time))/(k1+k2))
    B = (AO + BO) - A
    return A
end


function reaction_kinetics(A0, B0, time, dt=0.1, k1=0.1, k2=0.1)
    nsteps = Int64(time/dt)
    A = Vector{Float64}(undef,nsteps); A[1] = A0
    B = Vector{Float64}(undef,nsteps); B[1] = B0
    for ts in 1:(nsteps -1)
        A[ts+1] = A[ts] - k1 * dt * A[ts] + k2 * dt * B[ts]
        B[ts+1] = B[ts] + k1 * dt * A[ts] - k2 * dt * B[ts]
        error_mass = abs((A0 + B0) - 1 * (A[ts] + B[ts]))
        error_num = abs(exact_sol(A0,B0,ts,dt,k1,k2) - A[ts])
        println("d[B] = $(k1 * dt * A[ts] - k2 * dt * B[ts])")
        println("d[A] = $(-k1 * dt * A[ts] + k2 * dt * B[ts])")
        # Does not allow for negative [C]
        if A[ts+1] < 1.e-6
            A[ts+1] = 0.
        elseif B[ts+1] < 1.e-6
            B[ts+1] = 0.
        end
        # Print error_mass if bigger than 1.e-8
        if ts == (nsteps -1) || error_mass > 1.e-8
            println("With dt= $dt, k1= $k1, k2= $k2, at timestep = $(ts+1)")
            println("Mass balance error is $error_mass")
            println("[A] = $(A[ts]), [B] = $(B[ts])\n")
        end
    end
    return A, B
end


a0, b0 = 100, 0
time, dt = 10, 0.1

a = Vector{Float64}(undef,Int64(time/dt))
b = Vector{Float64}(undef,Int64(time/dt))

a, b = reaction_kinetics(a0,b0,time,0.1,0.1,0.1)
a, b = reaction_kinetics(a0,b0,time,0.1,0.001,0.1)
a, b = reaction_kinetics(a0,b0,time,0.1,0.1,0.001)

# dt > 0.5 and k1 or k2 > 1 makes error_mass to diverge
a, b = reaction_kinetics(a0,b0,100,1,1.1,1.2)
