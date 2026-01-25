# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_kv_value(key, [sep==], [trim=1])
#
#  Args:
#	key - key to match
#	OPTIONAL sep - key/value separator [=]
#	OPTIONAL trim - trim spaces when 1 [1]
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Extract the value for a key from key/value lines.
######################################################################
p6_filter_kv_value() {
    local key="$1"     # key to match
    local sep="${2:-=}" # key/value separator
    local trim="${3:-1}" # trim spaces when 1

    if [ "$trim" = "1" ]; then
        awk -F"$sep" -v k="$key" '$0 ~ k { print $2 }' | p6_filter_strip_spaces
    else
        awk -F"$sep" -v k="$key" '$0 ~ k { print $2 }'
    fi

    p6_return_filter
}
