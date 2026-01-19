# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_run__debug()
#
#>
######################################################################
p6_run__debug() {
    local msg="$1"

    p6_debug "p6_run: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: code rc = p6_run_code(code)
#
#  Args:
#	code -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_run_code() {
    local code="$*"

    p6_run__debug "code(): [code=$code]"
    p6_log "$code"
    eval "$code"
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: code rc = p6_run_yield(func, ...)
#
#  Args:
#	func -
#	... - 
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_run_yield() {
    local func="$1"
    shift 1

    p6_run_code "$func" "$@"
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: code rc = p6_run_read_cmd(cmd)
#
#  Args:
#	cmd -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_run_read_cmd() {
    local cmd="$*"

    p6_run_code "$cmd"
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: code rc = p6_run_write_cmd(cmd)
#
#  Args:
#	cmd -
#
#  Returns:
#	code - rc
#
#>
######################################################################
p6_run_write_cmd() {
    local cmd="$*"

    p6_run_code "$cmd"
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: code status = p6_run_retry(stop, fail, func, ...)
#
#  Args:
#	stop -
#	fail -
#	func -
#	... - 
#
#  Returns:
#	code - status
#
#  Environment:	 _
#>
######################################################################
p6_run_retry() {
    local stop="$1"
    local fail="$2"
    local func="$3"
    shift 3

    p6_dryrunning && p6_return

    local i=1
    while [ : ]; do
        local _status=$($func "$@")
        if $($stop "$_status" "$@"); then
            break
        fi

        i=$(p6_retry_delay_doubling "$i")
    done

    p6_return_code_as_code "$status"
}

######################################################################
#<
#
# Function: p6_run_parallel(i, parallel, things, cmd, ...)
#
#  Args:
#	i -
#	parallel -
#	things -
#	cmd -
#	... - 
#
#>
######################################################################
p6_run_parallel() {
    local i="$1"
    local parallel="$2"
    local things="$3"
    local cmd="$4"
    shift 4

    local thing
    for thing in $(p6_echo "$things"); do
        ((i = i % parallel))
        ((i++ == 0)) && wait
        p6_run__debug "run_parallel(): $cmd @ $thing"
        p6_echo "$cmd [$@] '$thing'"
        local rc="$($cmd $@ "$thing")" &
    done
}

######################################################################
#<
#
# Function: p6_run_serial(things, cmd, ...)
#
#  Args:
#	things -
#	cmd -
#	... - 
#
#>
######################################################################
p6_run_serial() {
    local things="$1"
    local cmd="$2"
    shift 2

    local thing
    for thing in $(p6_echo "$things"); do
        p6_run__debug "run_serial(): $cmd @ $thing"
        local rc="$($cmd $@ "$thing")"
    done

    p6_return_void
}

######################################################################
#<
#
# Function: true  = p6_run_if_not_in(script, skip_list)
#
#  Args:
#	script -
#	skip_list -
#
#  Returns:
#	true - 
#	false - 
#
#>
######################################################################
p6_run_if_not_in() {
    local script="${1%.sh}"
    local skip_list="$2"

    local item
    for item in $(p6_echo "$skip_list"); do
        if [ "$item" = "$script" ]; then
            p6_return_true
        fi
    done

    p6_return_false
}

######################################################################
#<
#
# Function: p6_run_script(cmd_env, shell, set_flags, cmd, [exts=.sh], arg_list, ...)
#
#  Args:
#	cmd_env -
#	shell -
#	set_flags -
#	cmd -
#	OPTIONAL exts - [.sh]
#	arg_list -
#	... - 
#
#>
######################################################################
p6_run_script() {
    local cmd_env="$1"
    local shell="$2"
    local set_flags="$3"
    local cmd="$4"
    local exts="${5:-.sh}"
    local arg_list="$6"
    shift 6

    local file=$(p6_file_cascade "${cmd}" "${exts}" $@)
    p6_run__debug "run(): $file"
    env -i ${cmd_env} ${shell} ${set_flags} ${file} $arg_list
}

######################################################################
#<
#
# Function: p6_run_if(thing, ...)
#
#  Args:
#	thing -
#	... - 
#
#>
######################################################################
p6_run_if() {
    local thing="$1"
    shift 1

    if type -f "$thing" >/dev/null 2>&1; then
        p6_run_code "$thing $@"
    else
        p6_run__debug "# DNE: $thing @=[$@]"
    fi
}

######################################################################
#<
#
# Function: p6_run_dir(dir, ...)
#
#  Args:
#	dir -
#	... - 
#
#>
######################################################################
p6_run_dir() {
    local dir="$1"
    shift 1

    local owd=$(pwd)

    p6_dir_cd "$dir"

    p6_run_code "$@"

    p6_dir_cd "$owd"
}

######################################################################
#<
#
# Function: p6_run_code_and_result(code)
#
#  Args:
#	code -
#
#>
######################################################################
p6_run_code_and_result() {
    local code="$*"

    eval "$(eval \"$code\")"
}
