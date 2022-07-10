# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_os__debug()
#
#>
######################################################################
p6_os__debug() {
    local msg="$1"

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
######################################################################
p6_os_name() {

    local name=$(uname -r)

    p6_os__debug "name(): $name"

    p6_return_str "$name"
}
