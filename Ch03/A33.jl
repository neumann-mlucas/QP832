# Solução para A32
using Printf


input_f(x) = x^2 + sin(10 * x)
input_df(x) = 2 * x + 10 * cos(10* x)


function steepest_descent(dfdx,dx)
    return  - dx * dfdx
end


function min_function(x_guess, step_size=0.01, max_steps=12)
    x_trial = x_best = x_guess
    f_trial = f_best = input_f(x_trial)
    for step in 1:max_steps
        @printf("step = %i  x = %+.2f  f(x) = %+.2f  df = %+.2f \n", step, x_trial, f_trial, f_trial - f_best)
        dfdx = input_df(x_trial)
        x_trial += steepest_descent(dfdx, step_size)
        f_trial = input_f(x_trial)
        if f_trial < f_best
            step_size *= 2
            f_best, x_best = f_trial, x_trial
        else
            step_size /= 2
        end
    end
    return x_best, f_best
end

for xi in LinRange(-2.0,2.0,10)
    x, f = min_function(xi)
    @printf("Start = %.4f, Xbest = %.4f, F min = %.4f \n\n", xi, x ,f)
end
