# Solução para A58, A59, A60, A61, A62
# 58) computedef
# 59) simplex implementado
# 60) o programa print o resultado da otimzação com randomsearch e simplex
# 61) data é um parametro do computdef e só pe lido uma vez
# 62) programa usa parametros default
include("./simplex_59.jl")
using CSV


function mse(v1,v2)
    @assert length(v1) == length(v2)
    @. return (v1 - v2) ^ 2
end


function reaction_kinetics(A0, B0, nsteps=1000, dt=0.01, k1=0.1, k2=0.02)
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
    end
    return A
end


function computdef(v,data)
    k1, k2 = v[1], v[2]
    cum_error = reaction_kinetics(10,0.1,1000,0.1,k1,k2) |> (x->mse(x,data)) |> cumsum
    return cum_error[end]
end

function randomsearch(f,xinit,data,ntrials)
  fbest = 1.e30
  xtray = xbest = xinit
  xtry = Vector{Float64}(undef,2)
  xbest = -10.0 .+ +2.0 .* rand(2)
  for i in 1:ntrials
    xtry = xbest .+ 1.e-2 .* (-1.0 .+ 2.0 .* rand(2))
    fx = f(xtry,data)
    if fx < fbest
      fbest = fx
      xbest = xtry
    end
  end
  println("-Best point found: ", xbest, " f = ", fbest)
  return fbest
end


data = CSV.read("data_55.csv")[:,1]

kguess = rand(2)
println("Random Search: ")
f = randomsearch(computdef,kguess,data,100)

println("Simplex Search: ")
kguess = rand(3,3)
f, x = simplex(computdef, kguess,data,100)
