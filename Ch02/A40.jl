using Plots

x = rand(1000)
y = rand(1000)
p1 = histogram(x)
p2 = scatter(x,y)
f = plot(p1,p2, layout=(2,1))
@show f
