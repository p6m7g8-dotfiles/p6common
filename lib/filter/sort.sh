# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_sort(...)
#
#  Args:
#	... - sort options
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Sort stdin using `sort` with any provided options.
######################################################################
p6_filter_sort() {
    shift 0 # sort options

    sort "$@"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_sort_unique(...)
#
#  Args:
#	... - sort options
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Sort stdin and remove duplicate lines.
######################################################################
p6_filter_sort_unique() {
    shift 0 # sort options

    sort -u "$@"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_sort_reverse(...)
#
#  Args:
#	... - sort options
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Sort stdin in reverse order.
######################################################################
p6_filter_sort_reverse() {
    shift 0 # sort options

    sort -r "$@"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_sort_numeric_reverse(...)
#
#  Args:
#	... - sort options
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Sort stdin numerically in reverse order.
######################################################################
p6_filter_sort_numeric_reverse() {
    shift 0 # sort options

    sort -nr "$@"

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_sort_by_key(key, [sep=])
#
#  Args:
#	key - sort key spec
#	OPTIONAL sep - field separator []
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Sort stdin by a key field with an optional field separator.
######################################################################
p6_filter_sort_by_key() {
    local key="$1"   # sort key spec
    local sep="${2:-}" # field separator

    if test -n "$sep"; then
        sort -t "$sep" -k "$key"
    else
        sort -k "$key"
    fi

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_sort_reverse_by_key(key, [sep=])
#
#  Args:
#	key - sort key spec
#	OPTIONAL sep - field separator []
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Sort stdin by a key field in reverse order.
######################################################################
p6_filter_sort_reverse_by_key() {
    local key="$1"   # sort key spec
    local sep="${2:-}" # field separator

    if test -n "$sep"; then
        sort -t "$sep" -r -k "$key"
    else
        sort -r -k "$key"
    fi

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_sort_by_column(column, [sep=])
#
#  Args:
#	column - column number (1-based)
#	OPTIONAL sep - field separator []
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Sort stdin by a column number with an optional separator.
######################################################################
p6_filter_sort_by_column() {
    local column="$1" # column number (1-based)
    local sep="${2:-}" # field separator
    local key="${column},${column}" # key range

    if test -n "$sep"; then
        p6_filter_sort_by_key "$key" "$sep"
    else
        p6_filter_sort_by_key "$key"
    fi

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_sort_numeric_by_column(column, [sep=])
#
#  Args:
#	column - column number (1-based)
#	OPTIONAL sep - field separator []
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Sort stdin numerically by a column number.
######################################################################
p6_filter_sort_numeric_by_column() {
    local column="$1" # column number (1-based)
    local sep="${2:-}" # field separator
    local key="${column},${column}" # key range

    if test -n "$sep"; then
        sort -t "$sep" -n -k "$key"
    else
        sort -n -k "$key"
    fi

    p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_sort_reverse_by_column(column, [sep=])
#
#  Args:
#	column - column number (1-based)
#	OPTIONAL sep - field separator []
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Sort stdin by a column number in reverse order.
######################################################################
p6_filter_sort_reverse_by_column() {
    local column="$1" # column number (1-based)
    local sep="${2:-}" # field separator
    local key="${column},${column}" # key range

    if test -n "$sep"; then
        p6_filter_sort_reverse_by_key "$key" "$sep"
    else
        p6_filter_sort_reverse_by_key "$key"
    fi

    p6_return_filter
}
