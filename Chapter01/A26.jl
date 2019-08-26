# Solução para A26
# 26)

function michaellis_menten(EO, SO, time, dt=0.1, kr=0.1, kf=0.01, kcat=10)
    nsteps = Int64(time/dt)
    T = collect(range(0, length=nsteps, step=Float64(dt)))
    E = Vector{Float64}(undef,nsteps); E[1] = EO
    S = Vector{Float64}(undef,nsteps); S[1] = SO
    ES = Vector{Float64}(undef,nsteps); ES[1] = 0.0
    P = 0.0
    for ts in 1:(nsteps -1)
        E[ts+1] = E[ts] - kr * dt * E[ts] * S[ts] + kf * dt * ES[ts] + kcat * dt * ES[ts]
        S[ts+1] = S[ts] - kr * dt * E[ts] * S[ts]
        ES[ts+1] = ES[ts] + kr * dt * E[ts] * S[ts] - kcat * dt * ES[ts]
        P += kcat * dt * ES[ts]

        if S[ts+1] < 1.e-6
            S[ts+1] = 0.
        end
        dES = kr * E[ts] * S[ts] - kcat * ES[ts]
        if dES < 1.e-6 && dES > -1.e-6
            println("\nES is contant!")
            println("dES=$dES  at time=$(T[ts])")
            println("with  SO=$SO  EO=$EO")
            println("with  kr=$kr  kf=$kf  kcat=$kcat")
            break
        end
        println("time = $(T[ts]) with P = $P")
    end
    return T, E, S, ES
end


t_lim = 100
dt = 0.01

t = Vector{Float64}(undef,Int64(t_lim/dt))
e = Vector{Float64}(undef,Int64(t_lim/dt))
s = Vector{Float64}(undef,Int64(t_lim/dt))
es = Vector{Float64}(undef,Int64(t_lim/dt))

t, e, s, es = michaellis_menten(1,10,100,0.01)
