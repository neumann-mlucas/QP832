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

function min_function(x_guess, step_size=0.01, max_step=1000)
    x = x_best = x_guess
    f_best = input_function(x)
    for step in 1:max_step
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

for xi in LinRange(-2.0,2.0,20)
    x, f = min_function(xi)
    @printf("Start = %.2f, Xbest = %.2f, F min = %.2f \n", xi, x ,f)
end
