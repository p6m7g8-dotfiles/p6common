# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "57"

    p6_test_start "p6_date__debug"
    (
        p6_test_run "p6_date__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_date_convert_seconds_to_hours"
    (
        p6_test_run "p6_date_convert_seconds_to_hours 3600"
        p6_test_assert_run_ok "seconds_to_hours" 0 "1.000"
    )
    p6_test_finish

    p6_test_start "p6_date_convert_ms_epoch_to_local"
    (
        p6_test_run "p6_date_convert_ms_epoch_to_local 0"
        p6_test_assert_run_rc "ms_epoch_to_local: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "ms_epoch_to_local: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "ms_epoch_to_local: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_date_range_fill__process"
    (
        p6_test_run "printf \"2024-01-02 5${P6_NL}\" > dates.txt; p6_date_range_fill__process 2024-01-02 dates.txt | tr '\\t' ' ' | sed 's/ $//'"
        p6_test_assert_run_ok "range_fill__process" 0 "2024-01-02 5"
    )
    p6_test_finish

    p6_test_start "p6_date_range_fill"
    (
        p6_test_run "printf \"2024-01-01 5${P6_NL}2024-01-03 7${P6_NL}\" > dates.txt; p6_date_range_fill 2024-01-01 2024-01-03 dates.txt | tr '\t' '|' | tr \"$P6_NL\" ' ' | sed 's/ $//'"
        p6_test_assert_run_rc "range_fill: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "range_fill: stdout"
        p6_test_ok "range_fill: stderr optional"
    )
    p6_test_finish

    p6_test_start "p6_date_fmt__date"
    (
        p6_test_run "p6_date_fmt__date 2024-01-02 '%Y-%m-%d' '%Y-%m-%d' '' ''"
        p6_test_assert_run_ok "fmt__date" 0 "2024-01-02"
    )
    p6_test_finish

    p6_test_start "p6_date_fmt__cli"
    (
        p6_test_run "p6_date_fmt__cli '+%Y'"
        p6_test_assert_run_rc "fmt__cli: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "fmt__cli: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "fmt__cli: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_date_fmt_relative_to_absolute"
    (
        p6_test_run "p6_date_fmt_relative_to_absolute '1 day'"
        p6_test_assert_run_rc "relative_to_absolute: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "relative_to_absolute: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "relative_to_absolute: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_date_math_move"
    (
        p6_test_run "p6_date_math_move 2024-01-02 -1d '%Y-%m-%d' '%Y-%m-%d'"
        p6_test_assert_run_ok "math_move" 0 "2024-01-01"
    )
    p6_test_finish

    p6_test_start "p6_date_math_delta_in_seconds"
    (
        p6_test_run "p6_date_math_delta_in_seconds 2024-01-01 2024-01-02 '%Y-%m-%d'"
        p6_test_assert_run_ok "delta_seconds" 0 "86400"
    )
    p6_test_finish

    p6_test_start "p6_date_math_delta_in_hours"
    (
        p6_test_run "p6_date_math_delta_in_hours 2024-01-01 2024-01-02 '%Y-%m-%d'"
        p6_test_assert_run_ok "delta_hours" 0 "24.000"
    )
    p6_test_finish

    p6_test_start "p6_date_point_now_epoch_seconds"
    (
        p6_test_run "p6_date_point_now_epoch_seconds"
        p6_test_assert_run_rc "now_epoch: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "now_epoch: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "now_epoch: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_date_point_now_ymd"
    (
        p6_test_run "p6_date_point_now_ymd"
        p6_test_assert_run_rc "now_ymd: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "now_ymd: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "now_ymd: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_date_point_today_ymd"
    (
        p6_test_run "p6_date_point_today_ymd"
        p6_test_assert_run_rc "today_ymd: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "today_ymd: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "today_ymd: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_date_point_yesterday_ymd"
    (
        p6_test_run "p6_date_point_yesterday_ymd"
        p6_test_assert_run_rc "yesterday_ymd: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "yesterday_ymd: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "yesterday_ymd: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_date_point_tomorrow_ymd"
    (
        p6_test_run "p6_date_point_tomorrow_ymd"
        p6_test_assert_run_rc "tomorrow_ymd: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "tomorrow_ymd: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "tomorrow_ymd: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_date_point_last_day_of_ym"
    (
        p6_test_run "p6_date_point_last_day_of_ym 2024 2"
        p6_test_assert_run_ok "last_day_of_ym" 0 "29"
    )
    p6_test_finish

    p6_test_start "p6_date_point_first_month_of_quarter"
    (
        p6_test_run "p6_date_point_first_month_of_quarter 2"
        p6_test_assert_run_ok "first_month_of_quarter" 0 "4"
    )
    p6_test_finish

    p6_test_start "p6_date_point_last_month_of_quarter"
    (
        p6_test_run "p6_date_point_last_month_of_quarter 4"
        p6_test_assert_run_ok "last_month_of_quarter" 0 "6"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
