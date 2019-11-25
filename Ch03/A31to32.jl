# Solução para A31 e A32
# 31) Prints melhor valor de x no intervalo [-2,2]
# 32) Novo steepest descent e printa quando melhor x foi achado
using Printf


input_f(x) = x^2 + sin(10 * x)
input_df(x) = 2 * x + 10 * cos(10* x)


function steepest_descent(dfdx,dx)
    return  - dx * dfdx
end


function min_function(x_guess, step_size=0.01, max_steps=100)
    num_step = 0
    x = x_best = x_guess
    f_best = input_f(x)
    for step in 1:max_steps
        dfdx = input_df(x)
        x += steepest_descent(dfdx, step_size)
        delta_f = input_f(x) - f_best
        if delta_f < 0.
            x_best = x
            f_best = input_f(x)
            num_step = step
        end
    end
    return x_best, f_best, num_step
end


for xi in LinRange(-2.0,2.0,20)
    x, f, step = min_function(xi)
    @printf("Start = %+.2f, Xbest = %+.2f, F min = %+.2f at step = %d\n", xi, x ,f, step)
end
