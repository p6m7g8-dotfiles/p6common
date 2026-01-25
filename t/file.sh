# shellcheck shell=bash

main() {

    . ../p6common/lib/_bootstrap.sh
    p6_bootstrap "../p6common"

    p6_test_setup "93"

    p6_test_start "p6_file__debug"
    (
        p6_test_run "p6_file__debug ping"
        p6_test_assert_run_ok "debug"
    )
    p6_test_finish

    p6_test_start "p6_file_mtime"
    (
        p6_test_run "echo hi > file.txt; p6_file_mtime file.txt"
        p6_test_assert_run_rc "mtime: rc" 0
        p6_test_assert_not_blank "$(p6_test_run_stdout)" "mtime: stdout"
        p6_test_assert_blank "$(p6_test_run_stderr)" "mtime: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_file_load"
    (
        p6_test_run "echo \"FOO=bar\" > config.sh; P6_PREFIX=; p6_file_load config.sh; echo \"\$FOO\""
        p6_test_assert_run_ok "load" 0 "bar"
    )
    p6_test_finish

    p6_test_start "p6_file_move"
    (
        p6_test_run "echo hi > src.txt; p6_file_move src.txt dst.txt"
        p6_test_assert_run_rc "move: rc" 0
        p6_test_assert_file_exists "dst.txt" "move: dst exists"
        p6_test_assert_file_not_exists "src.txt" "move: src removed"
    )
    p6_test_finish

    p6_test_start "p6_file_copy"
    (
        p6_test_run "echo hi > src.txt; p6_file_copy src.txt dst.txt"
        p6_test_assert_run_rc "copy: rc" 0
        p6_test_assert_file_exists "dst.txt" "copy: dst exists"
        p6_test_assert_file_exists "src.txt" "copy: src exists"
    )
    p6_test_finish

    p6_test_start "p6_file_rmf"
    (
        p6_test_run "echo hi > dead.txt; p6_file_rmf dead.txt"
        p6_test_assert_run_rc "rmf: rc" 0
        p6_test_assert_file_not_exists "dead.txt" "rmf: removed"
        p6_test_assert_blank "$(p6_test_run_stderr)" "rmf: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_file_unlink"
    (
        p6_test_run "echo hi > unlink.txt; p6_file_unlink unlink.txt"
        p6_test_assert_run_rc "unlink: rc" 0
        p6_test_assert_file_not_exists "unlink.txt" "unlink: removed"
        p6_test_assert_blank "$(p6_test_run_stderr)" "unlink: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_file_contains"
    (
        p6_test_run "echo foo > hay.txt; p6_file_contains foo hay.txt"
        p6_test_assert_run_ok "contains" 0 "foo"
    )
    p6_test_finish

    p6_test_start "p6_file_line_delete_last"
    (
        p6_test_run "printf \"a${P6_NL}b${P6_NL}\" > lines.txt; p6_file_line_delete_last lines.txt; cat lines.txt"
        p6_test_assert_run_ok "delete last" 0 "a"
    )
    p6_test_finish

    p6_test_start "p6_file_replace"
    (
        p6_test_run "echo foo > replace.txt; p6_file_replace replace.txt 's/foo/bar/'; cat replace.txt"
        p6_test_assert_run_ok "replace" 0 "bar"
    )
    p6_test_finish

    p6_test_start "p6_file_exists"
    (
        p6_test_run "p6_file_exists"
        p6_test_assert_run_ok "no arg: dne" 1

        p6_test_run "p6_file_exists" ""
        p6_test_assert_run_ok "\"\": dne" 1

        p6_test_run "p6_file_exists" ''
        p6_test_assert_run_ok "'': dne" 1

        p6_test_run "p6_file_exists" " "
        p6_test_assert_run_ok "\" \": dne" 1

        p6_test_run "p6_file_exists" "' '"
        p6_test_assert_run_ok "\' \': dne" 1

        p6_test_run "p6_file_exists" "/nonexistent"
        p6_test_assert_run_ok "/nonexistent: dne" 1

        p6_test_run "p6_file_exists" "$P6_TEST_DIR_ORIG/README.md"
        p6_test_assert_run_ok "Test file is -r per"
    )
    p6_test_finish

    p6_test_start "p6_file_executable"
    (
        p6_test_run "echo '#!/bin/sh' > exec.sh; chmod +x exec.sh; p6_file_executable exec.sh"
        p6_test_assert_run_ok "executable"
    )
    p6_test_finish

    p6_test_start "p6_file_display"
    (
        p6_test_run "echo hi > display.txt; p6_file_display display.txt"
        p6_test_assert_run_ok "display" 0 "hi"
    )
    p6_test_finish

    p6_test_start "p6_file_create"
    (
        p6_test_run "p6_file_create created.txt"
        p6_test_assert_run_rc "create: rc" 0
        p6_test_assert_file_exists "created.txt" "create: exists"
        p6_test_assert_blank "$(p6_test_run_stderr)" "create: stderr blank"
    )
    p6_test_finish

    p6_test_start "p6_file_write"
    (
        p6_test_run "p6_file_write write.txt hello; cat write.txt"
        p6_test_assert_run_ok "write" 0 "hello"
    )
    p6_test_finish

    p6_test_start "p6_file_append"
    (
        p6_test_run "echo a > append.txt; p6_file_append append.txt b; cat append.txt"
        p6_test_assert_run_ok "append" 0 "a
b"
    )
    p6_test_finish

    p6_test_start "p6_file_ma_sync"
    (
        p6_test_run "touch -t 202401010000 src.txt; touch -t 202401020000 dst.txt; p6_file_ma_sync src.txt dst.txt; if [ \"\$(stat -f '%m' src.txt)\" = \"\$(stat -f '%m' dst.txt)\" ]; then echo ok; else echo bad; fi"
        p6_test_assert_run_ok "ma_sync" 0 "ok"
    )
    p6_test_finish

    p6_test_start "p6_file_symlink"
    (
        p6_test_run "echo hi > target.txt; p6_file_symlink target.txt link.txt"
        p6_test_assert_run_rc "symlink: rc" 0
        p6_test_assert_file_exists "link.txt" "symlink: link exists"
        p6_test_assert_file_exists "target.txt" "symlink: target exists"
    )
    p6_test_finish

    p6_test_start "p6_file_cascade"
    (
        p6_test_run "echo ok > tool; p6_file_cascade tool '' ."
        p6_test_assert_run_ok "cascade" 0 "./tool"
    )
    p6_test_finish

    p6_test_start "p6_file_line_first"
    (
        p6_test_run "printf \"a${P6_NL}b${P6_NL}c${P6_NL}\" > rows.txt; p6_file_line_first rows.txt"
        p6_test_assert_run_ok "line_first" 0 "a"
    )
    p6_test_finish

    p6_test_start "p6_file_lines_last"
    (
        p6_test_run "printf \"a${P6_NL}b${P6_NL}c${P6_NL}\" > rows.txt; p6_file_lines_last rows.txt 2"
        p6_test_assert_run_ok "lines_last" 0 "b${P6_NL}c"
    )
    p6_test_finish

    p6_test_start "p6_file_lines"
    (
        p6_test_run "printf \"a${P6_NL}b${P6_NL}c${P6_NL}\" > rows.txt; p6_file_lines rows.txt"
        p6_test_assert_run_ok "lines" 0 "3"
    )
    p6_test_finish

    p6_test_start "p6_file_lines_except_first"
    (
        p6_test_run "printf \"a${P6_NL}b${P6_NL}c${P6_NL}\" > rows.txt; p6_file_lines_except_first rows.txt"
        p6_test_assert_run_ok "lines_except_first" 0 "b${P6_NL}c"
    )
    p6_test_finish

    p6_test_start "p6_file_lines_first"
    (
        p6_test_run "printf \"a${P6_NL}b${P6_NL}c${P6_NL}\" > rows.txt; p6_file_lines_first rows.txt 2"
        p6_test_assert_run_ok "lines_first" 0 "a${P6_NL}b"
    )
    p6_test_finish

    p6_test_start "p6_file_marker_delete_to_end"
    (
        p6_test_run "printf \"a${P6_NL}MARK${P6_NL}c${P6_NL}\" > rows.txt; p6_file_marker_delete_to_end rows.txt MARK; cat rows.txt"
        p6_test_assert_run_ok "marker_delete_to_end" 0 "a"
    )
    p6_test_finish

    p6_test_teardown
}

main "$@"
