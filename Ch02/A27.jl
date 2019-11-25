# Solução para A27
# [O3] by time stored in variable O3_vector
# Implementei de maneira diferente aos outros exercícios
function zero_order_step(CFC, CL; dt=0.01, k=0.001)
    if CFC > 0.0
        return CFC - k * dt, CL + k * dt
    else
        return 0.0,  CL
    end
end


function radicalar_step(CL, CLO, O3; dt=0.01, k1=0.1, k2=0.01)
    dCL = dt * (- k1 * CL * O3 + CLO * O3)
    dCLO = dt * (+ k1 * CL * O3 - CLO * O3)
    dO3 = dt * (-k1 * CL * O3 -k2 * CLO * O3)
    return CL + dCL, CLO + dCLO, O3 + dO3
end


nsteps = 50000
O3_vector = Vector{Float64}(undef,nsteps)

cl, clo = 0.0, 0.0
o3, cfc = 10.0, 0.05

for ts in 1:nsteps
    global o3, cfc, cl, clo
    # Update values
    cfc, cl = zero_order_step(cfc,cl)
    cl, clo, o3 = radicalar_step(cl, clo, o3)
    # Stores [O3]
    O3_vector[nsteps] = o3
end
