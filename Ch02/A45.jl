using Plots
# Function to be minimized
f(x::Vector{Float64}) = sum(x .^ 2)

# Minimizer by random search
function random_1(f,ntrial,dt)
  xtry = Vector{Float64}(undef,2)
  @. xbest = -10.0 + +2.0 * rand(2)
  fbest = f(xbest)
  for i in 1:ntrial
    @. guess = -1.0 + 2.0 * rand(2)
    @. xtry = xbest + dt * guess
    fx = f(xtry)
    if fx < fbest
      fbest = fx
      xbest = xtry
    end
  end
  println(" Best point found: f = ", fbest)
  return fbest
end

# Minimizer by random search
function random_2(f,ntrial,dt)
  xtry = Vector{Float64}(undef,2)
  xbest = -10.0 .+ +2.0 .* rand(2)
  fbest = f(xbest)
  for i in 1:ntrial
    @. guess = -1.0 + 2.0 * rand(2)
    fbest > 1 ? k = dt * fbest : k = dt * 0.1
    @. xtry = xbest + k * guess
    fx = f(xtry)
    if fx < fbest
      fbest = fx
      xbest = xtry
    end
  end
  println(" Best point found: f = ", fbest)
  return fbest
end


r1 = Vector{Float64}(undef,1000)
r2 = Vector{Float64}(undef,1000)
dt = 1.e-2
for n in 1:1000
    print(" N steps = $n  ")
    r1 = random_1(f,n,dt)
    r2 = random_2(f,n,dt)
end
