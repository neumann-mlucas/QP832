# Solução para A35, A36, A37, A38, A39
# 35) ndim = 2 resolve a atividade
# 36) notação vetorial
# 36) ndim = 3
# 36) ndim = 1000
using Printf
using LinearAlgebra


input_f(v) = v .* v
input_df(v) = 2 .* v
steepest_descent(dfdx, dx) = .- dx .* dfdx


function min_vectorial(v_guess, step_size=0.01, max_step=1000)

    v_trial = v_best = v_guess
    f_trial = f_best = norm(input_f(v_trial))
    final_step = 0

    for step in 1:max_step
        dfdx = input_df(v_trial)
        v_trial += steepest_descent(dfdx, step_size)
        f_trial = norm(input_f(v_trial))
        if f_trial < f_best
            step_size *= 2
            f_best, v_best = f_trial, v_trial
        else
            step_size /= 2
            if abs(f_trial - f_best) < 1.e-8
                final_step = step
                break
            end
        end
    end
    return v_best, f_best, final_step
end

ndim = 10
for i in 1:10
    v = 10 * rand(1:10,ndim)
    a, b, c = min_vectorial(v)
    @printf("try number %i, f(v_init) = %+05.2f \n", i, norm(input_f(v)))
    @printf(" final f(v) = %+e at step = %i\n", b, c)
end
