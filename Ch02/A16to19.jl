# Solução para A16, A17, A18, A19
# 16) dt como um parâmetro da função
# 17) [A], k1, nsteps e dt são paramtros da função e podem ser variados
# 18) Concentrações negativas são evitadas com uma clásula "if ..."
# 19) B0 como um parâmetro e a função retorna [B]
function reaction_kinetics(A0, B0, nsteps=100, dt=0.1, k1=0.1)
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
    return A, B
end


a0, b0, time, dt = 100, 0, 1000, 0.1
a = Vector{Float64}(undef,Int64(time/dt))
b = Vector{Float64}(undef,Int64(time/dt))
a, b = reaction_kinetics(100,0,time)
