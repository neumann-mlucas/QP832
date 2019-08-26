#= using Plots =#

function zero_order_step(Float64 :: CFC, Float64 :: CL; t=0.01, k=0.01)
    return (CFC > 0.0 ? (CFC - k * t, CL + k * t) : (0.0, CL))
    #= if CFC > 0.0 =#
    #=     return CFC - k * dt, CL + k * t =#
    #= else =#
    #=     return 0.0,  CL =#
    #= end =#
    #= return a, b =#
end

function radicalar_step(CL, CLO, O3; dt=0.01, k1=0.1, k2=0.01)
    dCL = dt * (- k1 * CL * O3 + CLO * O3)
    dCLO = dt * (+ k1 * CL * O3 - CLO * O3)
    dO3 = dt * (-k1 * CL * O3 -k2 * CLO * O3)
    return CL + dCL, CLO + dCLO, O3 + dO3
end

#= gr() =#
o3 = Float64(0.1)
cfc = Float64(0.001)
cl = Float64(0.0)
clo = Float64(0.0)
for nsteps in 1:1000
    cfc, cl = zero_order_step(cfc,cl)
    cl, clo, o3 = radicalar_step(cl, clo, o3)
    #= scatter!(nsteps, O3, label="O_3", color="red") =#
    #= scatter!(nsteps, CL, label="Cl", color="green") =#
    #= scatter!(nsteps, CLO, label="ClO", color="blue") =#
    #= scatter!(nsteps, CFC, label="CFC", color="pink") =#
end
