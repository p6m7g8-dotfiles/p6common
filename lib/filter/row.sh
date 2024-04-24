# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_filter_row_select()
#
#>
######################################################################
p6_filter_row_select() {
    local selector="$1"
    local flag_case="${2:-}"

    case $flag_case in
    *insensitive*) flag_case="-i" ;;
    *) ;;
    esac

    grep "$flag_case" "$selector"
}

######################################################################
#<
#
# Function: p6_filter_row_select_and_after(selector, count)
#
#  Args:
#	selector -
#	count -
#
#>
######################################################################
p6_filter_row_select_and_after() {
    local selector="$1"
    local count="$2"

    grep -A $count "$selector"
}

######################################################################
#<
#
# Function: p6_filter_row_exclude(selector)
#
#  Args:
#	selector -
#
#>
######################################################################
p6_filter_row_exclude() {
    local selector="$1"

    grep -v "$selector"
}

######################################################################
#<
#
# Function: p6_filter_row_first(n)
#
#  Args:
#	n -
#
#>
######################################################################
p6_filter_row_first() {
    local n="$1"

    head -n $n
}

######################################################################
#<
#
# Function: p6_filter_row_last(n)
#
#  Args:
#	n -
#
#>
######################################################################
p6_filter_row_last() {
    local n="$1"

    tail -n $n
}

######################################################################
#<
#
# Function: p6_filter_row_from_end(n)
#
#  Args:
#	n -
#
#>
######################################################################
p6_filter_row_from_end() {
    local n="$1"

    tail -n "$n" | head -n "1"
}

######################################################################
#<
#
# Function: p6_filter_row_n(n)
#
#  Args:
#	n -
#
#>
######################################################################
p6_filter_row_n() {
    local n="$1"

    sed -n "${n}p"
}

