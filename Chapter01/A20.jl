# Solução para A20
# Forma analítica do programa anterior
# Compara os dois outputs
function numerical_sol(AO, BO, time, dt=0.1, k1=0.1)
    nsteps = Int64(time/dt)
    T = collect(range(0, length=nsteps, step=Float64(dt)))
    A = Vector{Float64}(undef,nsteps); A[1] = AO
    B = Vector{Float64}(undef,nsteps); B[1] = BO
    for ts in 1:(nsteps -1)
        A[ts+1] = A[ts] - k1 * dt * A[ts]
        B[ts+1] = B[ts] + k1 * dt * A[ts]
        if A[ts] < 1.e-6
            A[ts+1] = 0.
        elseif B[ts] < 1.e-6
            B[ts+1] = 0.
        end
    end
    return A
end

function analitical_sol(AO, BO, time, dt=0.1, k1=0.1)
    nsteps = Int(time/dt)
    T = collect(range(0, length=nsteps, step=Float64(dt)))
    A = Vector{Float64}(undef,nsteps)
    B = Vector{Float64}(undef,nsteps)
    for ts in 1:nsteps-1
        A[ts] = AO * exp(-k1*T[ts])
        B[ts] = BO * exp(+k1*T[ts])
    end
    return A
end


delta = Vector{Float64}(undef,1000)
delta = analitical_sol(100,0,100) - numerical_sol(100,0,100)
