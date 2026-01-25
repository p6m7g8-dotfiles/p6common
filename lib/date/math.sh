# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date_math_move(date, offset, fmt_from, fmt_to)
#
#  Args:
#	date - input date string
#	offset - date offset expression
#	fmt_from - input format
#	fmt_to - output format
#
#>
#/ Synopsis
#/    Applies a date offset and converts from fmt_from to fmt_to.
######################################################################
p6_date_math_move() {
    local date="$1"     # input date string
    local offset="$2"   # date offset expression
    local fmt_from="$3" # input format
    local fmt_to="$4"   # output format

    date=$(p6_date_fmt__date "$date" "$fmt_from" "$fmt_to" "$offset")

    p6_return_date "$date"
}

######################################################################
#<
#
# Function: int delta = p6_date_math_delta_in_seconds(d1, d2, in_fmt)
#
#  Args:
#	d1 - first date
#	d2 - second date
#	in_fmt - input format
#
#  Returns:
#	int - delta
#
#>
#/ Synopsis
#/    Returns the delta between d1 and d2 in seconds.
######################################################################
p6_date_math_delta_in_seconds() {
    local d1="$1"     # first date
    local d2="$2"     # second date
    local in_fmt="$3" # input format

    local out_fmt="%s"
    local d1s=$(p6_date_fmt__date "$d1" "$in_fmt" "$out_fmt" "" "")
    local d2s=$(p6_date_fmt__date "$d2" "$in_fmt" "$out_fmt" "" "")

    local delta=$(p6_math_sub "$d2s" "$d1s")

    p6_return_int "$delta"
}

######################################################################
#<
#
# Function: float delta_hours = p6_date_math_delta_in_hours(d1, d2, fmt)
#
#  Args:
#	d1 - first date
#	d2 - second date
#	fmt - input format
#
#  Returns:
#	float - delta_hours
#
#>
#/ Synopsis
#/    Returns the delta between d1 and d2 in hours.
######################################################################
p6_date_math_delta_in_hours() {
    local d1="$1"  # first date
    local d2="$2"  # second date
    local fmt="$3" # input format

    local delta_hours
    if p6_string_blank "$d1" || p6_string_blank "$d2"; then
        delta_hours=not_a_float
    else
        local delta_seconds=$(p6_date_math_delta_in_seconds "$d1" "$d2" "$fmt")
        delta_hours=$(p6_date_convert_seconds_to_hours "$delta_seconds")
    fi

    p6_return_float "$delta_hours"
}
