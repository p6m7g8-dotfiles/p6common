# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_json__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for JSON helpers.
######################################################################
p6_json__debug() {
    local msg="$1" # debug message

    p6_debug "p6_json: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_json_eval(...)
#
#  Args:
#	... - jq filter and options (reads JSON from stdin)
#
#>
#/ Synopsis
#/    Run jq against JSON on stdin.
######################################################################
p6_json_eval() {

    jq "$@"

    p6_return_stream
}

######################################################################
#<
#
# Function: p6_json_from_file(file)
#
#  Args:
#	file - JSON file path
#
#>
#/ Synopsis
#/    Stream JSON file content to stdout.
######################################################################
p6_json_from_file() {
    local file="$1" # JSON file path

    cat "$file"

    p6_return_stream
}
