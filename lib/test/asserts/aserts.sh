# shellcheck shell=bash

#
# Runing something
#
# /tmp/p6/test
# /tmp/p6/test/[bail]
# /tmp/p6/test/i
# /tmp/p6/test/n
# /tmp/p6/test/t/
# /tmp/p6/test/t/<rand>/
# /tmp/p6/test/t/<rand>/fixtures/
# /tmp/p6/test/t/<rand>/cli
# # /tmp/p6/test/t/<rand>/in
# /tmp/p6/test/t/<rand>/stdout
# /tmp/p6/test/t/<rand>/stderr
# /tmp/p6/test/t/<rand>/rv
#
# XXX: stdin
######################################################################
#<
#
# Function: p6_test_run()
#
#>
######################################################################
p6_test_run() {

    local dir
    dir=$(p6_test_dir)

    #    local cli=$dir/cli
    #    local stdin=$dir/in
    local stdout=$dir/stdout
    local stderr=$dir/stderr
    local rv=$dir/rv

    exec 3>&1 4>&2 >"$stdout" 2>"$stderr"
    eval "$@"
    local rc=$?
    exec 1>&3 2>&4

    echo $rc >"$rv"
    echo "$@" >"$dir"/cli
}

######################################################################
#<
#
# Function: p6_test_run_stdout()
#
#>
######################################################################
p6_test_run_stdout() {

    local dir
    dir=$(p6_test_dir)
    cat "$dir"/stdout
}

######################################################################
#<
#
# Function: p6_test_run_stderr()
#
#>
######################################################################
p6_test_run_stderr() {

    local dir
    dir=$(p6_test_dir)
    cat "$dir"/stderr
}

######################################################################
#<
#
# Function: p6_test_run_rc()
#
#>
######################################################################
p6_test_run_rc() {

    local dir
    dir=$(p6_test_dir)
    cat "$dir"/rv
}

#
# Assertions.
#
#
#
######################################################################
#<
#
# Function: p6_test_assert_run_ok(description, [rv=0], [stdout=], [stderr=])
#
#  Args:
#	description -
#	OPTIONAL rv - [0]
#	OPTIONAL stdout - []
#	OPTIONAL stderr - []
#
#>
######################################################################
p6_test_assert_run_ok() {
    local description="$1"
    local rv="${2:-0}"
    local stdout="${3:-}"
    local stderr="${4:-}"

    p6_test_assert_run_rc "$description: return code success" "$rv"

    if [ -n "$stdout" ]; then
        p6_test_assert_eq "$(p6_test_run_stdout)" "$stdout" "$description: custom stdout matches"
    else
        p6_test_assert_run_no_stdout "$description"
    fi

    if [ -n "$stderr" ]; then
        p6_test_assert_eq "$(p6_test_run_stderr)" "$stderr" "$description: custom stderr matches"
    else
        p6_test_assert_run_no_stderr "$description"
    fi
}

######################################################################
#<
#
# Function: p6_test_assert_run_rc(description, rv)
#
#  Args:
#	description -
#	rv -
#
#>
######################################################################
p6_test_assert_run_rc() {
    local description="$1"
    local rv="$2"

    local rc
    rc=$(p6_test_run_rc)

    if p6_test_assert_eq "$rc" "$rv" "$description" "$reason"; then
        p6_test_tap_diagnostic "stdout: $(p6_test_run_stdout)"
        p6_test_tap_diagnostic "stderr: $(p6_test_run_stderr)"
    fi
}

######################################################################
#<
#
# Function: p6_test_assert_run_no_output(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_run_no_output() {
    local description="$1"
    local reason="$2"

    p6_test_assert_run_no_stdout "$description" "$reason"
    p6_test_assert_run_no_stderr "$description" "$reason"
}

######################################################################
#<
#
# Function: p6_test_assert_run_no_stdout(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_run_no_stdout() {
    local description="$1"
    local reason="$2"

    p6_test_assert_blank "$(p6_test_run_stdout)" "$description: no stdout"
}

######################################################################
#<
#
# Function: p6_test_assert_run_no_stderr(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_run_no_stderr() {
    local description="$1"
    local reason="$2"

    p6_test_assert_blank "$(p6_test_run_stderr)" "$description: no stderr"
}

######################################################################
#<
#
# Function: p6_test_assert_run_not_ok(description, reason)
#
#  Args:
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_run_not_ok() {
    local description="$1"
    local reason="$2"

    local dir
    dir=$(p6_test_dir)
    local rc
    rc=$(cat "$dir"/rv)

    p6_test_assert_not_eq "$rc" "0" "$description" "$reason"
}

######################################################################
#<
#
# Function: p6_test_assert_eq(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_eq() {
    local val="$1"
    local const="$2"
    local description="$3"
    local reason="$4"

    local rv=-1
    case $val in
    $const)
        rv=1
        p6_test_tap_ok "$description" "$reason"
        ;;
    *)
        rv=0
        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "expected [$const], got [$val]"
        ;;
    esac

    return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_not_eq(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_not_eq() {
    local val="$1"
    local const="$2"
    local description="$3"
    local reason="$4"

    local rv=-1
    case $val in
    $const)
        rv=0
        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "expected [$const], got [$val]"
        ;;
    *)
        rv=1
        p6_test_tap_ok "$description" "$reason"
        ;;
    esac

    return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_len(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_len() {
    local val="$1"
    local const="$2"
    local description="$3"
    local reason="$4"

    local len
    len=$(echo $val | wc -m | awk '{print $1}')
    len=$(($len - 1))

    p6_test_assert_eq "$len" "$const" "$description" "$reason"
}

######################################################################
#<
#
# Function: p6_test_assert_contains(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_contains() {
    local val="$1"
    local const="$2"
    local description="$3"
    local reason="$4"

    echo "$const" | grep -q "$val" >/dev/null
    local rv=$?
    case $rv in
    1)
        p6_test_tap_ok "$description" "$reason"
        ;;
    0)
        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "val [$val] is not contained in [$const]"
        ;;
    esac

    return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_not_contains(val, const, description, reason)
#
#  Args:
#	val -
#	const -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_not_contains() {
    local val="$1"
    local const="$2"
    local description="$3"
    local reason="$4"

    local rv=-1
    case $val in
    $const)
        rv=0
        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "expected [$const], got [$val]"
        ;;
    *)
        rv=1
        p6_test_tap_ok "$description" "$reason"
        ;;
    esac

    return $rv

}

######################################################################
#<
#
# Function: p6_test_assert_blank(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_blank() {
    local val="$1"
    local description="$2"
    local reason="$3"

    local rv=-1
    if [ -z "$val" ]; then
        rv=1
        p6_test_tap_ok "$description" "$reason"
    else
        rv=0
        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "[$val] is not blank"
    fi

    return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_not_blank(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_not_blank() {
    local val="$1"
    local description="$2"
    local reason="$3"

    local rv=-1
    if [ -n "$val" ]; then
        rv=1
        p6_test_tap_ok "$description" "$reason"
    else
        rv=0
        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "[$val] is not blank"
    fi

    return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_dir_exists(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#  Environment:	 DNE
#>
######################################################################
p6_test_assert_dir_exists() {
    local val="$1"
    local description="$2"
    local reason="$3"

    local rv=-1
    if [ -d "$val" ]; then
        rv=1
        p6_test_tap_ok "$description" "$reason"
    else
        rv=0
        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "[$val] DNE"
    fi

    return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_dir_not_exists(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_dir_not_exists() {
    local val="$1"
    local description="$2"
    local reason="$3"

    local rv=-1
    if [ ! -d "$val" ]; then
        rv=1
        p6_test_tap_ok "$description" "$reason"
    else
        rv=0
        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "[$val] Exists!"
    fi

    return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_file_exists(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#  Environment:	 DNE
#>
######################################################################
p6_test_assert_file_exists() {
    local val="$1"
    local description="$2"
    local reason="$3"

    local rv=-1
    if [ -f "$val" ]; then
        rv=1
        p6_test_tap_ok "$description" "$reason"
    else
        rv=0
        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "[$val] DNE"
    fi

    return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_file_not_exists(val, description, reason)
#
#  Args:
#	val -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_file_not_exists() {
    local val="$1"
    local description="$2"
    local reason="$3"

    local rv=-1
    if [ ! -f "$val" ]; then
        rv=1
        p6_test_tap_ok "$description" "$reason"
    else
        rv=0
        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "[$val] Exists!"
    fi

    return $rv
}

######################################################################
#<
#
# Function: p6_test_assert_file_matches(file1, file2, description, reason)
#
#  Args:
#	file1 -
#	file2 -
#	description -
#	reason -
#
#>
######################################################################
p6_test_assert_file_matches() {
    local file1="$1"
    local file2="$2"
    local description="$3"
    local reason="$4"

    local rv=-1
    if cmp -s "$file1" "$file2"; then
        rv=1
        p6_test_tap_ok "$description" "$reason"
    else
        rv=0

        local dir
        dir=$(p6_test_dir)
        diff -u "$file1" "$file2" >"$dir"/delta.txt

        p6_test_tap_not_ok "$description" "$reason"
        p6_test_tap_diagnostic "[$file2] Differs:\n$(cat $dir/delta.txt)"
    fi

    return $rv
}
