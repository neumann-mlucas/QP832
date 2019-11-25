# Solução A55
# Gerei um CSV com "$ julia A55.jl > data_55.csv"


function exact_sol(AO, BO, time, k1=0.1, k2=0.02)
    A = AO * ((k2 + k1 * exp(-(k1+k2) * time))/(k1+k2))
    B = (AO + BO) - A
    return A
end


function reaction_kinetics(AO, BO, nsteps=1000, dt=0.01, k1=0.1, k2=0.02)
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
        exact = exact_sol(AO,BO,ts * dt,k1,k2)
        print("$(A[ts+1]),$(exact)\n")
    end
    return A
end


A0 = 10
B0 = 0.1
k1 = 0.8
k2 = 0.28
println("CA_sim, CA_exact")
println("10.0,10.0")
reaction_kinetics(A0,B0,1000,0.01,k1,k2)

