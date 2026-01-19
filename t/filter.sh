# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "144"

    p6_test_start "p6_filter__debug"
    (
        p6_test_run "p6_filter__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_filter_sort"
    (
        p6_test_run "printf 'b\na\n' | p6_filter_sort"
        p6_test_assert_run_ok "sort" 0 "a
b"

        p6_test_run "printf 'b\na\n' | p6_filter_sort_reverse"
        p6_test_assert_run_ok "sort_reverse" 0 "b
a"
    )
    p6_test_finish

    p6_test_start "p6_filter_translate"
    (
        p6_test_run "echo 'foo bar foo' | p6_filter_translate_glob_to_underscore foo"
        p6_test_assert_run_ok "glob_to_underscore" 0 "_ bar _"

        p6_test_run "echo '(a)(b)' | p6_filter_translate_parens_to_slash"
        p6_test_assert_run_ok "parens_to_slash" 0 "/a//b/"

        p6_test_run "echo 'a/!b' | p6_filter_translate_trailing_slash_bang_to_bang"
        p6_test_assert_run_ok "trailing_slash_bang_to_bang" 0 "a!b"

        p6_test_run "echo 'a b' | p6_filter_translate_space_to_underscore"
        p6_test_assert_run_ok "space_to_underscore" 0 "a_b"

        p6_test_run "echo 'a b' | p6_filter_translate_space_to_tab"
        p6_test_assert_run_ok "space_to_tab" 0 "a	b"

        p6_test_run "echo 'a|b||NULL' | p6_filter_translate_words_to_sql_list '|'"
        p6_test_assert_run_ok "words_to_sql_list" 0 "('a', 'b', NULL, NULL)"

        p6_test_run "printf 'a\tb\n' | p6_filter_translate_tab_to_pipe"
        p6_test_assert_run_ok "tab_to_pipe" 0 "a|b"

        p6_test_run "echo 'x' | p6_filter_translate_start_to_arg 'pre-'"
        p6_test_assert_run_ok "start_to_arg" 0 "pre-x"

        p6_test_run "echo 'a||b|' | p6_filter_translate_blank_to_null"
        p6_test_assert_run_ok "blank_to_null" 0 "a|NULL|b|NULL"

        p6_test_run "echo \"'NULL'|x\" | p6_filter_translate_quoted_null_to_null"
        p6_test_assert_run_ok "quoted_null_to_null" 0 "NULL|x"

        p6_test_run "echo 'foo  bar  baz severity  rest' | p6_filter_convert_multispace_delimited_columns_to_pipes"
        p6_test_assert_run_ok "multispace_to_pipes" 0 "foo|bar|baz severity|rest"

        p6_test_run "echo 'a/b|c|' | p6_filter_translate_first_field_slash_to_pipe"
        p6_test_assert_run_ok "first_field_slash_to_pipe" 0 "a|b|c|"

        p6_test_run "echo 'a|b' | p6_filter_insert_null_at_position 4"
        p6_test_assert_run_ok "insert_null_at_position" 0 "a|b|NULL|NULL"
    )
    p6_test_finish

    p6_test_start "p6_filter_sql_escape_single_quote"
    (
        p6_test_run "echo \"it's\" | p6_filter_sql_escape_single_quote"
        p6_test_assert_run_ok "sql_escape_single_quote" 0 "it''s"
    )
    p6_test_finish

    p6_test_start "p6_filter_aggregate"
    (
        p6_test_run "printf 'a\nb\na\n' | p6_filter_aggregate_map_reduce | tr -s ' ' | sed -e 's/^ //'"
        p6_test_assert_run_ok "map_reduce" 0 "2 a
1 b"

        p6_test_run "printf 'g1\t1\t2\ng1\t3\t4\n' | p6_filter_aggregate_table_by_group_with_count | awk '{print \$1 \"\t\" \$2 \"\t\" \$3}'"
        p6_test_assert_run_ok "table_by_group_with_count" 0 "g1	2	3.000"

        p6_test_run "printf 'g1\t2\t4\ng2\t3\t2\n' | p6_filter_aggregate_table_with_count | awk '{print \$1 \"\t\" \$2}'"
        p6_test_assert_run_ok "table_with_count" 0 "5	1.200"
    )
    p6_test_finish

    p6_test_start "p6_filter_date"
    (
        p6_test_run "echo 0 | p6_filter_translate_ms_epoch_to_iso8601_local"
        p6_test_assert_run_rc "ms_epoch_to_iso8601_local: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "ms_epoch_to_iso8601_local: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "ms_epoch_to_iso8601_local: stderr blank"

        p6_test_run "echo '2024-01-02 03:04:05|x' | p6_filter_translate_date_to_iso8601_utc 1 '%Y-%m-%d %H:%M:%S' '|' '|'"
        p6_test_assert_run_ok "date_to_iso8601_utc" 0 "2024-01-02T03:04:05Z|x"
    )
    p6_test_finish

    p6_test_start "p6_filter_column"
    (
        p6_test_run "p6_filter_column_pluck__all_to_action"
        p6_test_assert_run_ok "pluck__all_to_action" 0 "{ print \$0 }"

        p6_test_run "p6_filter_column_pluck__list_to_action 1,3"
        p6_test_assert_run_rc "pluck__list_to_action: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "pluck__list_to_action: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "pluck__list_to_action: stderr blank"

        p6_test_run "p6_filter_column_pluck__range_to_action 2-3"
        p6_test_assert_run_ok "pluck__range_to_action" 0 "{ print \$2,\$3 }"

        p6_test_run "p6_filter_column_pluck__column_to_action 2"
        p6_test_assert_run_ok "pluck__column_to_action" 0 "{ print \$2 }"

        p6_test_run "echo 'a b c' | p6_filter_column_pluck 2"
        p6_test_assert_run_ok "column_pluck" 0 "b"

        p6_test_run "echo 'a b' | p6_filter_column_swap '|'"
        p6_test_assert_run_ok "column_swap" 0 "b | a"

        p6_test_run "echo 'a|b|c' | p6_filter_columns_count '|'"
        p6_test_assert_run_ok "columns_count" 0 "3"
    )
    p6_test_finish

    p6_test_start "p6_filter_string_first_character"
    (
        p6_test_run "echo foo | p6_filter_string_first_character"
        p6_test_assert_run_ok "string_first_character" 0 "f"
    )
    p6_test_finish

    p6_test_start "p6_filter_strip"
    (
        p6_test_run "echo \"'a'\" | p6_filter_single_quote_strip"
        p6_test_assert_run_ok "single_quote_strip" 0 "a"

        p6_test_run "echo '\"a\"' | p6_filter_double_quote_strip"
        p6_test_assert_run_ok "double_quote_strip" 0 "a"

        p6_test_run "echo \"'a'\" | p6_filter_quotes_strip"
        p6_test_assert_run_ok "quotes_strip" 0 "a"

        p6_test_run "echo '  a' | p6_filter_leading_spaces_strip"
        p6_test_assert_run_ok "leading_spaces_strip" 0 "a"

        p6_test_run "echo 'a  ' | p6_filter_trailing_spaces_strip"
        p6_test_assert_run_ok "trailing_spaces_strip" 0 "a"

        p6_test_run "echo '  a  ' | p6_filter_leading_and_trailing_spaces_strip"
        p6_test_assert_run_ok "leading_and_trailing_spaces_strip" 0 "a"

        p6_test_run "echo 'a b c' | p6_filter_spaces_strip"
        p6_test_assert_run_ok "spaces_strip" 0 "abc"

        p6_test_run "echo 'a1!' | p6_filter_alnum_strip"
        p6_test_assert_run_ok "alnum_strip" 0 "!"

        p6_test_run "echo 'a_1!' | p6_filter_alnum_and_underscore_strip"
        p6_test_assert_run_ok "alnum_and_underscore_strip" 0 "!"

        p6_test_run "echo 'path/' | p6_filter_trailing_slash_strip"
        p6_test_assert_run_ok "trailing_slash_strip" 0 "path"
    )
    p6_test_finish

    p6_test_start "p6_filter_row"
    (
        p6_test_run "printf 'a\nb\n' | p6_filter_row_select b"
        p6_test_assert_run_ok "row_select" 0 "b"

        p6_test_run "printf 'a\nb\nc\n' | p6_filter_row_select_and_after b 1"
        p6_test_assert_run_ok "row_select_and_after" 0 "b
c"

        p6_test_run "printf 'a\nb\n' | p6_filter_row_exclude b"
        p6_test_assert_run_ok "row_exclude" 0 "a"

        p6_test_run "printf 'a\nb\n' | p6_filter_row_first 1"
        p6_test_assert_run_ok "row_first" 0 "a"

        p6_test_run "printf 'a\nb\nc\n' | p6_filter_row_last 1"
        p6_test_assert_run_ok "row_last" 0 "c"

        p6_test_run "printf 'a\nb\nc\n' | p6_filter_row_from_end 2"
        p6_test_assert_run_ok "row_from_end" 0 "b"

        p6_test_run "printf 'a\nb\nc\n' | p6_filter_row_n 2"
        p6_test_assert_run_ok "row_n" 0 "b"

        p6_test_run "printf 'a\nb\n' | p6_filter_rows_count | tr -d ' '"
        p6_test_assert_run_ok "rows_count" 0 "2"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
