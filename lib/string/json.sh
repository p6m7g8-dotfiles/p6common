# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_json__debug(msg)
#
#  Args:
#	msg -
#
#  Depends:	 p6_echo p6_json
#>
######################################################################
p6_json__debug() {
    local msg="$1"

    p6_debug "p6_json: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_json_eval(json, ...)
#
#  Args:
#	json -
#	... - 
#
#  Depends:	 p6_echo
#>
######################################################################
p6_json_eval() {
    local json="$1"
    shift 1

    p6_echo "$json" | jq "$@"
}
