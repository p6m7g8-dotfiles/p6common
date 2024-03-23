# shellcheck shell=bash

#
# Filters
#  Filters expect to process stdin and send output to stdout
#  aka someone will say ..... | p6_filter_* | ...
#

######################################################################
#<
#
# Function: p6_filter__debug()
#
#>
######################################################################
p6_filter__debug() {
    local msg="$1"

    p6_debug "p6_filter: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_filter_single_quote_strip()
#
#>
######################################################################
p6_filter_single_quote_strip() {

    sed -e "s,',,g"
}

######################################################################
#<
#
# Function: p6_filter_double_quote_strip()
#
#>
######################################################################
p6_filter_double_quote_strip() {

    sed -e 's,",,g'
}

######################################################################
#<
#
# Function: p6_filter_quotes_strip()
#
#>
######################################################################
p6_filter_quotes_strip() {

    sed -e "s,[\"\'],,g"
}

######################################################################
#<
#
# Function: p6_filter_leading_spaces_strip()
#
#>
######################################################################
p6_filter_leading_spaces_strip() {

    sed -e 's,^ *,,g'
}

######################################################################
#<
#
# Function: p6_filter_trailing_spaces_strip()
#
#>
######################################################################
p6_filter_trailing_spaces_strip() {

    sed -e 's, *$,,g'
}

######################################################################
#<
#
# Function: p6_filter_leading_and_trailing_spaces_strip()
#
#>
######################################################################
p6_filter_leading_and_trailing_spaces_strip() {

    p6_filter_trailing_spaces_strip | p6_filter_leading_spaces_strip
}

######################################################################
#<
#
# Function: p6_filter_spaces_strip()
#
#>
######################################################################
p6_filter_spaces_strip() {

    sed -e 's, *,,g'
}

######################################################################
#<
#
# Function: p6_filter_alnum_strip()
#
#>
######################################################################
p6_filter_alnum_strip() {

    sed -e 's,[a-zA-Z0-9],,g'
}

######################################################################
#<
#
# Function: p6_filter_alnum_and_underscore_strip()
#
#>
######################################################################
p6_filter_alnum_and_underscore_strip() {

    sed -e 's,[a-zA-Z0-9_],,g'
}

######################################################################
#<
#
# Function: p6_filter_to_underscore(glob)
#
#  Args:
#	glob -
#
#>
######################################################################
p6_filter_to_underscore() {
    local glob="$1"

    sed -e "s,$glob,_,g"
}

######################################################################
#<
#
# Function: p6_filter_select(selector, [flag_case=])
#
#  Args:
#	selector -
#	OPTIONAL flag_case - []
#
#>
######################################################################
p6_filter_select() {
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
# Function: p6_filter_select_and_after(selector, count)
#
#  Args:
#	selector -
#	count -
#
#>
######################################################################
p6_filter_select_and_after() {
    local selector="$1"
    local count="$2"

    grep -A $count "$selector"
}

######################################################################
#<
#
# Function: p6_filter_exclude(selector)
#
#  Args:
#	selector -
#
#>
######################################################################
p6_filter_exclude() {
    local selector="$1"

    grep -v "$selector"
}

######################################################################
#<
#
# Function: p6_filter_first(n)
#
#  Args:
#	n -
#
#>
######################################################################
p6_filter_first() {
    local n="$1"

    head -n $n
}

######################################################################
#<
#
# Function: p6_filter_last(n)
#
#  Args:
#	n -
#
#>
######################################################################
p6_filter_last() {
    local n="$1"

    tail -n $n
}

######################################################################
#<
#
# Function: p6_filter_from_end(n)
#
#  Args:
#	n -
#
#>
######################################################################
p6_filter_from_end() {
    local n="$1"

    tail -n "$n" | head -n "1"
}

######################################################################
#<
#
# Function: p6_filter_sort()
#
#>
######################################################################
p6_filter_sort() {

    sort
}

######################################################################
#<
#
# Function: p6_filter_reverse()
#
#>
######################################################################
p6_filter_reverse() {

    sort -r
}

######################################################################
#<
#
# Function: p6_filter_pluck_column(n, [split=])
#
#  Args:
#	n -
#	OPTIONAL split - []
#
#>
######################################################################
p6_filter_pluck_column() {
    local n="$1"
    local split="${2:-}"

    awk -F"$split" "{ print \$$n }" | p6_filter_leading_and_trailing_spaces_strip
}

######################################################################
#<
#
# Function: p6_filter_pluck_column_when_row_selected(n, selector, [split=])
#
#  Args:
#	n -
#	selector -
#	OPTIONAL split - []
#
#>
######################################################################
p6_filter_pluck_column_when_row_selected() {
    local n="$1"
    local selector="$2"
    local split="${3:-}"

    awk -F"$split" -v k=$selector '{ /$k/ print \$$n }' | p6_filter_leading_and_trailing_spaces_strip
}

######################################################################
#<
#
# Function: p6_filter_translate_parens_to_slash()
#
#>
######################################################################
p6_filter_translate_parens_to_slash() {

    sed -e 's,(,/,g' -e 's,),/,g'
}

######################################################################
#<
#
# Function: p6_filter_remove_trailing_slash()
#
#>
######################################################################
p6_filter_remove_trailing_slash() {

    sed -e 's,/$,,'
}

######################################################################
#<
#
# Function: p6_filter_translate_trailing_slash_bang_to_bang()
#
#>
######################################################################
p6_filter_translate_trailing_slash_bang_to_bang() {

    sed -e 's,/\!,!,g'
}

######################################################################
#<
#
# Function: p6_filter_translate_space_to_underscore()
#
#>
######################################################################
p6_filter_translate_space_to_underscore() {

    sed -e 's, ,_,g'
}

######################################################################
#<
#
# Function: p6_filter_pluck_column_to_end(n, [split= ])
#
#  Args:
#	n -
#	OPTIONAL split - [ ]
#
#>
######################################################################
p6_filter_pluck_column_to_end() {
    local n="$1"
    local split="${2:- }"

    cut -d"$split" -f "${n}-"
}
