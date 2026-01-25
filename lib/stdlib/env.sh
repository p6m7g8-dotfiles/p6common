# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_env__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for env helpers.
######################################################################
p6_env__debug() {
    local msg="$1" # debug message

    p6_debug "p6_env: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_env_export(var, val)
#
#  Args:
#	var - variable name
#	val - variable value
#
#>
#/ Synopsis
#/    Export an environment variable with a value.
######################################################################
p6_env_export() {
    local var="$1" # variable name
    local val="$2" # variable value

    p6_run_code "export $var=\"$val\""

    p6_env__debug "export(): [$var] => [$val]"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_env_export_un(var)
#
#  Args:
#	var - variable name
#
#>
#/ Synopsis
#/    Unset an exported environment variable.
######################################################################
p6_env_export_un() {
    local var="$1" # variable name

    p6_env__debug "export_un(): [$var]"

    unset $var

    p6_return_void
}

######################################################################
#<
#
# Function: p6_env_list(glob)
#
#  Args:
#	glob - grep pattern
#
#>
#/ Synopsis
#/    List environment variables, optionally filtered by a pattern.
######################################################################
p6_env_list() {
    local glob="$1" # grep pattern

    if p6_string_blank "$glob"; then
        env
    else
        env | p6_filter_row_select "$glob"
    fi

    p6_return_void
}

######################################################################
#<
#
# Function: p6_env_list_p6()
#
#>
#/ Synopsis
#/    List all P6-related environment variables.
######################################################################
p6_env_list_p6() {

    p6_env_list "^P6" | p6_filter_sort

    p6_return_void
}
