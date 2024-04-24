# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date__date()
#
#>
#/ Synopsis
#/    Calculates and returns a date string adjusted by a specified offset
#/    from a given date or the current date, formatted according to the
#/    specified format.
######################################################################
p6_date__date() {
    local fmt="$1"            # Output format
    local offset="${2:-}"     # i.e. +1d -2w
    local offset_fmt="${3:-}" # Format of `date` i.e. %Y-%m-%d
    local date="${4:-}"       # current date if blank

    p6_date__debug "_date(): date \"$fmt\" \"$offset\" \"$offset_fmt\" \"$date\""

    local dt
    if p6_string_blank "$offset"; then
        dt=$(date "+$fmt")
    else
        if p6_string_blank "$offset_fmt"; then
            dt=$(date -v "$offset" "+$fmt")
        else
            dt=$(date -j -f "$offset_fmt" "$date" -v "$offset" "+$fmt")
        fi
    fi

    p6_date__debug "_date(): date \"$dt\""

    p6_return_date "$dt"
}

######################################################################
#<
#
# Function: p6_date_fmt_relative_to_absolute(relative)
#
#  Args:
#	relative -
#
#>
######################################################################
p6_date_fmt_relative_to_absolute() {
    local relative="$1"

    local number=$(p6_echo "$relative" | p6_filter_column_pluck "1")
    local unit=$(p6_echo "$relative" | p6_filter_column_pluck "2")
    local unit_abbr=$(p6_echo "$unit" | p6_filter_string_first_character)

    local absolute=$(p6_date__date "%Y-%m-%d" "-${number}${unit_abbr}")

    p6_return_date "$absolute"
}
