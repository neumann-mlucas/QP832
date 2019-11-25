# Solução para A26
# Gera o gráfico de Velocidade da formação de produto X concentração de sustrato inicial
# plot(s0, vel)

function michaellis_menten(E0, S0, nsteps, dt=0.1, kr=0.1, kf=0.01, kcat=10)
    # E + S <-> ES --> E + P
    E = Vector{Float64}(undef,nsteps); E[1] = E0
    S = Vector{Float64}(undef,nsteps); S[1] = S0
    ES = Vector{Float64}(undef,nsteps); ES[1] = 0.0

    dP = Vector{Float64}(undef,nsteps); dP[1] = 0.0
    dES = Vector{Float64}(undef,nsteps); dES[1] = 0.0

    for ts in 1:(nsteps -1)

        E[ts+1] = E[ts] - kr * dt * E[ts] * S[ts] + kf * dt * ES[ts] + kcat * dt * ES[ts]
        S[ts+1] = S[ts] - kr * dt * E[ts] * S[ts]
        ES[ts+1] = ES[ts] + kr * dt * E[ts] * S[ts] - kcat * dt * ES[ts]

        dP[ts+1] = kcat * dt * ES[ts]
        dES[ts+1] = kr * E[ts] * S[ts] - kcat * ES[ts]

        # Does not allow for negative [S]
        if S[ts+1] < 1.e-6
            S[ts+1] = 0.
        end
        # Check if stationary TS aproximation is valid
        if dES[ts] > 1.e-6 && dES[ts] < -1.e-6
            println("\nES is not contant!")
            println("dES=$dES  at time=$ts")
            println("With  SO=$SO  EO=$EO")
            println("kr=$kr  kf=$kf  kcat=$kcat\n\n")
            break
        end
    end
    # By time = 2000 the velocity should have converged to a maximum value
    return maximum(dP)

    # To check kinetics
    #= return E, S, ES, dP, dES =#
end


e0 = 0.05
time, dt = 2000, 0.01

dp = Vector{Float64}(undef,Int64(10000))
s0 = collect(LinRange(0.1,500,10000))
for (n, si) in enumerate(s0)
    dp[n] = michaellis_menten(e0,si,time,dt)
end

