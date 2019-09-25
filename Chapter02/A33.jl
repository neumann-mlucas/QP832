using Printf

function input_function(x)
    return x^2 + sin(10 * x)
end

function input_derivative(x)
    return 2 * x + 10 * cos(10 * x)
end

function steepest_descent(dfdx,dx)
    return  - dx * dfdx
end

function min_function(x_guess, step_size=0.01, max_step=25)
    println()

    x_trial = x_best = x_guess
    f_trial = f_best = input_function(x_trial)
    for step in 1:max_step
        @printf("step = %i  x = %.2f  f(x) = %.2f  df = %.2f \n", step, x_trial, f_trial, f_trial - f_best)
        dfdx = input_derivative(x_trial)
        x_trial += steepest_descent(dfdx, step_size)
        f_trial = input_function(x_trial)
        if f_trial < f_best
            step_size *= 2
            f_best, x_best = f_trial, x_trial
        else
            step_size /= 2
        end
    end
    return x_best, f_best
end

for xi in LinRange(-2.0,2.0,4)
    x, f = min_function(xi)
    @printf("Start = %.4f, Xbest = %.4f, F min = %.4f \n", xi, x ,f)
end
