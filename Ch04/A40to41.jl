# Solução para A40 e A41
# para visualizar "julia -i A40to41.jl" & "plot(f)"
using Plots


x = rand(1000)
y = rand(1000)
p1 = histogram(x)
p2 = scatter(x,y)
p = plot(p1,p2, layout=(2,1))
