# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_curl(...)
#
#  Args:
#	... - curl arguments
#
#>
#/ Synopsis
#/    Thin wrapper around curl; all callers build their own args.
######################################################################
p6_curl() {
    shift 0

    p6_log "curl $*"
    curl "$@"

    p6_return_void
}
