using Plots
# Function to be minimized
f(x::Vector{Float64}) = sum(x .^ 2)

# Minimizer by random search
function randomsearch(f,ntrial)
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
  println(" Best point found: f = ", fbest)
  return fbest
end


result = Vector{Float64}(undef,10000)
for n in 1:10000
    print(" N steps = $n  ")
    result[n] = randomsearch(f,n)
end
