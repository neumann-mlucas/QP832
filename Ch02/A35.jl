using Printf
using LinearAlgebra

function input_function(v)
    return v .* v
end

function input_derivative(v)
    return 2 * v
end

function steepest_two(dfdx,dx)
    return  - dx * dfdx
end

function min_vectorial(v_guess, step_size=0.01, max_step=1000)

    v_trial = v_best = v_guess
    f_trial = f_best = norm(input_function(v_trial))
    for step in 1:max_step

        dfdx = input_derivative(v_trial)
        v_trial += steepest_two(dfdx, step_size)
        f_trial = norm(input_function(v_trial))

        if f_trial < f_best
            step_size *= 2
            f_best, v_best = f_trial, v_trial
        else
            step_size /= 2
            if abs(f_trial - f_best) < 1.e-6
                return v_best, f_best, step
            end
        end
    end
end

for xi in 1:10
    v = 10 * rand(4)
    a, b, c = min_vectorial(v)
    println(" try number $xi, v init has $v ")
    println(" final dist = $b \n")
end
