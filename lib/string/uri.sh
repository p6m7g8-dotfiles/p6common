# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_uri__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
#/ Synopsis
#/    Emit a namespaced debug message for URI helpers.
######################################################################
p6_uri__debug() {
    local msg="$1" # debug message

    p6_debug "p6_uri: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: path name = p6_uri_name(uri)
#
#  Args:
#	uri - input URI/path
#
#  Returns:
#	path - name
#
#>
#/ Synopsis
#/    Return the basename component of a URI or path.
######################################################################
p6_uri_name() {
    local uri="$1" # input URI/path

    local name=
    if ! p6_string_blank "$uri"; then
        name=$(basename $uri)
    fi
    p6_uri__debug "name(): $uri -> $name"

    p6_return_path "$name"
}

######################################################################
#<
#
# Function: path name = p6_uri_path(uri)
#
#  Args:
#	uri - input URI/path
#
#  Returns:
#	path - name
#
#>
#/ Synopsis
#/    Return the directory component of a URI or path.
######################################################################
p6_uri_path() {
    local uri="$1" # input URI/path

    local name=
    if ! p6_string_blank "$uri"; then
        name=$(dirname $uri)
    fi
    p6_uri__debug "path(): [uri=$uri] -> [name=$name]"

    p6_return_path "$name"
}
