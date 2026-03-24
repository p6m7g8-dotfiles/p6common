# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_os__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for OS helpers.
######################################################################
p6_os__debug() {
    local msg="$1" # debug message

    p6_debug "p6_os: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: str name = p6_os_name()
#
#  Returns:
#	str - name
#
#>
#/ Synopsis
#/    Return the OS kernel release string.
######################################################################
p6_os_name() {

    local name=$(uname -r)

    p6_os__debug "name(): $name"

    p6_return_str "$name"
}

######################################################################
#<
#
# Function: bool rv = p6_os_type(cmd)
#
#  Args:
#	cmd - command name
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true if cmd is found via type (PATH, functions, aliases).
######################################################################
p6_os_type() {
    local cmd="$1" # command name

    type "$cmd" >/dev/null 2>&1
    local rv=$?

    p6_os__debug "type(): $cmd -> $rv"

    p6_return_bool "$rv"
}

######################################################################
#<
#
# Function: bool rv = p6_cmd_exists(cmd)
#
#  Args:
#	cmd - command name or absolute path
#
#  Returns:
#	bool - rv
#
#>
#/ Synopsis
#/    Return true if cmd is available: uses p6_file_executable for
#/    absolute paths, type for names resolved via PATH or defined
#/    as a function/alias.
######################################################################
p6_cmd_exists() {
    local cmd="$1" # command name or absolute path

    local rv
    if p6_string_starts_with "$cmd" "/"; then
        p6_file_executable "$cmd"
        rv=$?
    else
        p6_os_type "$cmd"
        rv=$?
    fi

    p6_os__debug "cmd_exists(): $cmd -> $rv"

    p6_return_bool "$rv"
}
