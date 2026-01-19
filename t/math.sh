# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "27"

    p6_test_start "p6_math_lt"
    (
        p6_test_run "p6_math_lt 1 2"
        p6_test_assert_run_ok "lt"
    )
    p6_test_finish

    p6_test_start "p6_math_lte"
    (
        p6_test_run "p6_math_lte 2 2"
        p6_test_assert_run_ok "lte"
    )
    p6_test_finish

    p6_test_start "p6_math_gt"
    (
        p6_test_run "p6_math_gt 3 2"
        p6_test_assert_run_ok "gt"
    )
    p6_test_finish

    p6_test_start "p6_math_gte"
    (
        p6_test_run "p6_math_gte 3 3"
        p6_test_assert_run_ok "gte"
    )
    p6_test_finish

    p6_test_start "p6_math_sub"
    (
        p6_test_run "p6_math_sub 5 3"
        p6_test_assert_run_ok "sub" 0 "2"
    )
    p6_test_finish

    p6_test_start "p6_math_inc"
    (
        p6_test_run "p6_math_inc 5"
        p6_test_assert_run_ok "inc default" 0 "6"
    )
    p6_test_finish

    p6_test_start "p6_math_dec"
    (
        p6_test_run "p6_math_dec 5"
        p6_test_assert_run_ok "dec default" 0 "4"
    )
    p6_test_finish

    p6_test_start "p6_math_multiply"
    (
        p6_test_run "p6_math_multiply 3 4"
        p6_test_assert_run_ok "multiply" 0 "12"
    )
    p6_test_finish

    p6_test_start "p6_math_range_generate"
    (
        p6_test_run "p6_math_range_generate 1 3 | tr '\n' ' ' | sed 's/ $//'"
        p6_test_assert_run_ok "range" 0 "1 2 3"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
