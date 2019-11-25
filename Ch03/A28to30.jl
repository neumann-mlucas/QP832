# Solução para A28, A29 e A30
# 28) delta x é um parametro da função
# 29) O loop print o resultado da otimização variando delta x
# 30) max_steps implementada
using Printf


input_f(x) = x^2
input_df(x) = 2 * x


function steepest_descent(dfdx,dx)
    return  - dx * dfdx / abs(dfdx)
end


function min_function(x_guess, step_size=0.1, max_steps=49)

    println("X guess = $x_guess, step size = $step_size")
    x = x_best = x_guess
    f_best = input_f(x)
    delta_f = -1.

    for step in 1:max_steps
        # Check progress
        if step % 10 == 0
            @printf("step = %i  x = %+.2f  f(x) = %+.2f  df = %+.2f \n", step, x, input_f(x), delta_f)
        end
        dfdx = input_df(x)
        x += steepest_descent(dfdx, step_size)
        # Update x_best
        delta_f = input_f(x) - f_best
        if delta_f < 0.
            x_best = x
            f_best = input_f(x)
        end
    end
    @printf("step = %i  x = %+.2f  f(x) = %+.2f  df = %+.2f \n", max_steps, x, input_f(x), delta_f)
    return x_best, f_best
end


for step in LinRange(0.1,2,20)
    min_function(rand(1:100),step)
end
