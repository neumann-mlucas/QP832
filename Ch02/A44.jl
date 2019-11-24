using Plots
# Function to be minimized
f(x::Vector{Float64}) = sum(x .^ 2)

# Minimizer by random search
function randomsearch_1(f,ntrial)
  fbest = 1.e30
  x = Vector{Float64}(undef,2)
  xbest = Vector{Float64}(undef,2)
  for i in 1:ntrial
    x = -10.0 .+ 20.0 .* rand(2)
    fx = f(x)
    if fx < fbest
      fbest = fx
      xbest = x
    end
  end
  return fbest
end

# Minimizer by random search
function randomsearch_2(f,ntrial,dt)
  fbest = 1.e30
  xtry = Vector{Float64}(undef,2)
  xbest = -10.0 .+ +20.0 .* rand(2)
  for i in 1:ntrial
    xtry = xbest .+ dt .* (-1.0 .+ 2.0 .* rand(2))
    fx = f(xtry)
    if fx < fbest
      fbest = fx
      xbest = xtry
    end
  end
  return fbest
end


nsteps = 20000
r1 = Vector{Float64}(undef,1000)
r2 = Vector{Float64}(undef,1000)
for (idx, dt) in enumerate(LinRange(0.1,1.e-2, 1000))
    f1 = randomsearch_1(f,nsteps)
    f2 = randomsearch_2(f,nsteps,dt)
    r1[idx] = f1
    r2[idx] = f2
end
