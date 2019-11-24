function exact_sol(AO, BO, time, k1=0.1, k2=0.02)
    A = AO * ((k2 + k1 * exp(-(k1+k2) * time))/(k1+k2))
    B = (AO + BO) - A
    return A
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
        print("$(A[ts+1]),")
        exact = exact_sol(AO,BO,ts * dt,k1,k2)
        println("$(exact)")
    end
    return T, A, B
end

A0 = 10
B0 = 0.1
k1 = 0.8
k2 = 0.28
println("CA_sim, CA_exact")
println("10.0,10.0")
reaction_kinetics(A0,B0, 100, 0.01,k1,k2)

