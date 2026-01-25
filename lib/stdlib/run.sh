# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_run__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for run helpers.
######################################################################
p6_run__debug() {
    local msg="$1" # debug message

    p6_debug "p6_run: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_run_code(code)
#
#  Args:
#	code - command string
#
#>
#/ Synopsis
#/    Log and execute a command string.
######################################################################
p6_run_code() {
    local code="$*" # command string

    p6_run__debug "code(): [code=$code]"
    p6_log "$code"
    eval "$code"
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_run_yield(func, ...)
#
#  Args:
#	func - function to call
#	... - function arguments
#
#>
#/ Synopsis
#/    Invoke a function with arguments and return its status.
######################################################################
p6_run_yield() {
    local func="$1" # function to call
    shift 1         # function arguments

    p6_run_code "$func" "$@"
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_run_read_cmd(cmd)
#
#  Args:
#	cmd - command string
#
#>
#/ Synopsis
#/    Run a command string (read-style helper).
######################################################################
p6_run_read_cmd() {
    local cmd="$*" # command string

    p6_run_code "$cmd"
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_run_write_cmd(cmd)
#
#  Args:
#	cmd - command string
#
#>
#/ Synopsis
#/    Run a command string (write-style helper).
######################################################################
p6_run_write_cmd() {
    local cmd="$*" # command string

    p6_run_code "$cmd"
    local rc=$?

    p6_return_code_as_code "$rc"
}

######################################################################
#<
#
# Function: p6_run_retry(stop, fail, func, ...)
#
#  Args:
#	stop - stop callback
#	fail - failure callback (unused)
#	func - function to call
#	... - function arguments
#
#  Environment:	 _
#>
#/ Synopsis
#/    Retry a function until a stop condition is met.
######################################################################
p6_run_retry() {
    local stop="$1" # stop callback
    local fail="$2" # failure callback (unused)
    local func="$3" # function to call
    shift 3         # function arguments

    p6_dryrunning && p6_return

    local i=1
    while [ : ]; do
        local _status=$($func "$@") # status from callback invocation
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
#	i - starting index
#	parallel - max parallel jobs
#	things - item list
#	cmd - command to run
#	... - command arguments
#
#>
#/ Synopsis
#/    Run a command in parallel over a list of items.
######################################################################
p6_run_parallel() {
    local i="$1"        # starting index
    local parallel="$2" # max parallel jobs
    local things="$3"   # item list
    local cmd="$4"      # command to run
    shift 4             # command arguments

    local thing
    for thing in $(p6_echo "$things"); do
        ((i = i % parallel))
        ((i++ == 0)) && wait
        p6_run__debug "run_parallel(): $cmd @ $thing"
        p6_echo "$cmd [$@] '$thing'"
        local rc="$($cmd $@ "$thing")" & # rc from background command
    done
}

######################################################################
#<
#
# Function: p6_run_serial(things, cmd, ...)
#
#  Args:
#	things - item list
#	cmd - command to run
#	... - command arguments
#
#>
#/ Synopsis
#/    Run a command serially over a list of items.
######################################################################
p6_run_serial() {
    local things="$1" # item list
    local cmd="$2"    # command to run
    shift 2           # command arguments

    local thing
    for thing in $(p6_echo "$things"); do
        p6_run__debug "run_serial(): $cmd @ $thing"
        local rc="$($cmd $@ "$thing")" # rc from command
    done

    p6_return_void
}

######################################################################
#<
#
# Function: true  = p6_run_if_not_in(script, skip_list)
#
#  Args:
#	script - script name
#	skip_list - whitespace-separated list
#
#  Returns:
#	true - 
#	false - 
#
#>
#/ Synopsis
#/    Return true when a script is found in the skip list.
######################################################################
p6_run_if_not_in() {
    local script="${1%.sh}" # script name
    local skip_list="$2"    # whitespace-separated list

    local item
    for item in $(p6_echo "$skip_list"); do
        if p6_string_eq "$item" "$script"; then
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
#	cmd_env - env var assignments
#	shell - shell to execute
#	set_flags - shell flags
#	cmd - script base name
#	OPTIONAL exts - allowed extensions [.sh]
#	arg_list - argument list string
#	... - search paths
#
#>
#/ Synopsis
#/    Resolve and run a script with a clean environment.
######################################################################
p6_run_script() {
    local cmd_env="$1"  # env var assignments
    local shell="$2"    # shell to execute
    local set_flags="$3" # shell flags
    local cmd="$4"      # script base name
    local exts="${5:-.sh}" # allowed extensions
    local arg_list="$6" # argument list string
    shift 6             # search paths

    local file=$(p6_file_cascade "${cmd}" "${exts}" $@) # resolved script file
    p6_run__debug "run(): $file"
    env -i ${cmd_env} ${shell} ${set_flags} ${file} $arg_list
}

######################################################################
#<
#
# Function: p6_run_if(thing, ...)
#
#  Args:
#	thing - function or command name
#	... - arguments
#
#>
#/ Synopsis
#/    Run a function or command if it exists.
######################################################################
p6_run_if() {
    local thing="$1" # function or command name
    shift 1          # arguments

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
#	dir - working directory
#	... - command to run
#
#>
#/ Synopsis
#/    Run a command within a directory and return to the original.
######################################################################
p6_run_dir() {
    local dir="$1" # working directory
    shift 1        # command to run

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
#	code - command string
#
#>
#/ Synopsis
#/    Eval a command and eval its output into the shell.
######################################################################
p6_run_code_and_result() {
    local code="$*" # command string

    eval "$(eval \"$code\")"
}
