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
