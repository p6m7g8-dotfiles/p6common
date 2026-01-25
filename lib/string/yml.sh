# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_yml__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emits a debug message scoped to the yml helper.
######################################################################
p6_yml__debug() {
    local msg="$1" # debug message

    p6_debug "p6_yml: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_yml_eval(yml, ...)
#
#  Args:
#	yml - YAML content
#	... - yq options and query
#
#>
#/ Synopsis
#/    Evaluates a yq query against a YAML string.
######################################################################
p6_yml_eval() {
    local yml="$1" # YAML content
    shift 1        # yq options and query

    p6_echo "$yml" | yq "$@"
}

######################################################################
#<
#
# Function: p6_yml_from_file(file)
#
#  Args:
#	file - YAML file path
#
#>
#/ Synopsis
#/    Reads YAML from file and emits it via yq.
######################################################################
p6_yml_from_file() {
    local file="$1" # YAML file path

    yq <"$file"

    p6_return_void
}
