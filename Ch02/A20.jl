# Solução para A20
# Variável error armazena discrapância das duas funçães
function numerical_kinetics(A0, B0, time, dt=0.1, k1=0.1)
    nsteps = Int(time/dt)
    A = Vector{Float64}(undef,nsteps); A[1] = A0
    B = Vector{Float64}(undef,nsteps); B[1] = B0
    for ts in 1:(nsteps -1)
        A[ts+1] = A[ts] - k1 * dt * A[ts]
        B[ts+1] = B[ts] + k1 * dt * A[ts]
        if A[ts+1] < 1.e-6
            A[ts+1] = 0.
        elseif B[ts+1] < 1.e-6
            B[ts+1] = 0.
        end
    end
    return A
end


function analitical_kinetics(A0, B0, time, dt=0.1, k1=0.1)
    nsteps = Int(time/dt)
    T = collect(range(0, length=nsteps, step=Float64(dt)))
    A = Vector{Float64}(undef,nsteps)
    B = Vector{Float64}(undef,nsteps)
    @. A = A0 * exp(-k1 * T)
    @. B = B0 * exp(+k1 * T)
    return A
end


a0, b0, time, dt = 100, 0 , 100, 0.1
error = Vector{Float64}(undef,Int64(time/dt))
error = analitical_kinetics(a0,b0,time) .- numerical_kinetics(a0,b0,time)
