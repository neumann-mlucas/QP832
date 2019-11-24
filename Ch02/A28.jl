using Printf

function input_function(x)
    return x^2
end

function input_derivative(x)
    return 2 * x
end

function steepest_descent(dfdx,dx)
    return  - dx * dfdx / abs(dfdx)
end

function min_function(x_guess, step_size=0.1, max_step=1000)

    x = x_best = x_guess
    f_best = input_function(x)
    delta_f = -1.

    for step in 1:max_step

        @printf("step = %i  x = %.2f  f(x) = %.2f  df = %.2f \n", step, x, input_function(x), delta_f)

        dfdx = input_derivative(x)
        x += steepest_descent(dfdx, step_size)
        delta_f = input_function(x) - f_best
        if delta_f < 0.
            x_best = x
            f_best = input_function(x)
        else
            continue
        end
    end
    return x_best, f_best
end

min_function(2)
