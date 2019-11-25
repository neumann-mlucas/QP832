# Solução para A34
# Print a numero de etapas até atingir o mínimo
using Printf

function input_function(x)
    return x^2 + sin(10 * x)
end

function input_derivative(x)
    return 2 * x + 10 * cos(10 * x)
end

function steepest_one(dfdx,dx)
    return  - dx * dfdx / abs(dfdx)
end

function steepest_two(dfdx,dx)
    return  - dx * dfdx
end

function min_32(x_guess, step_size=0.01,max_step=1000)
    x_trial = x_best = x_guess
    f_trial = f_best = input_function(x_trial)
    for step in 1:max_step
        dfdx = input_derivative(x_trial)
        x_trial += steepest_one(dfdx, step_size)
        f_trial = input_function(x_trial)
        if f_trial < f_best
            f_best, x_best = f_trial, x_trial
        else
            return x_best, f_best, step
        end
    end
end

function min_33(x_guess, step_size=0.01, max_step=1000)

    x_trial = x_best = x_guess
    f_trial = f_best = input_function(x_trial)
    for step in 1:max_step
        dfdx = input_derivative(x_trial)
        x_trial += steepest_two(dfdx, step_size)
        f_trial = input_function(x_trial)
        if f_trial < f_best
            step_size *= 2
            f_best, x_best = f_trial, x_trial
        else
            step_size /= 2
            if abs(f_trial - f_best) < 1.e-6
                return x_best, f_best, step
            end
        end
    end
end

for xi in LinRange(-2.0,2.0,20)
    x1, f1, s1 = min_32(xi)
    x2, f2, s2 = min_33(xi)
    @printf("Start = %.2f, Xbest = %.8f, n_steps = %i \n", xi, x1 ,s1)
    @printf("Start = %.2f, Xbest = %.8f, n_steps = %i \n\n", xi, x2 ,s2)
end
