# Solução para A27

using Plots

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

ntotal = 50000
vec = Vector{Float64}(undef,ntotal)

cl, clo = 0.0, 0.0
o3, cfc = 10.0, 0.05

for nsteps in 1:ntotal
    global o3, cfc, cl, clo
    cfc, cl = zero_order_step(cfc,cl)
    cl, clo, o3 = radicalar_step(cl, clo, o3)
    # stores o3 concentration
    vec[nsteps] = o3
end

#= plot([1:ntotal],vec) =#
