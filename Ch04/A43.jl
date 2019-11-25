# Solução para A43
# 43) Plota com "julia -i A43.jl" & "plot(result)"
using Plots

# Function to be minimized
f(x::Vector{Float64}) = sum(x .^ 2)

# Minimizer by random search
function randomsearch(f,ntrials)
  fbest = 1.e30
  xtry = Vector{Float64}(undef,2)
  xbest = -10.0 .+ +2.0 .* rand(2)
  for i in 1:ntrials
    xtry = xbest .+ 1.e-2 .* (-1.0 .+ 2.0 .* rand(2))
    fx = f(xtry)
    if fx < fbest
      fbest = fx
      xbest = xtry
    end
  end
  println(" Best point found: f = ", fbest)
  return fbest
end


result = Vector{Float64}(undef,10000)
for n in 1:10000
    print(" N steps = $n  ")
    result[n] = randomsearch(f,n)
end
