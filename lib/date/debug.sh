# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_dt__debug()
#
#>
######################################################################
p6_date__debug() {
    local msg="$1"

    p6_debug "p6_dt: $msg"

    p6_return_void
}
