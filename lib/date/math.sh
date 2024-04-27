# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date_math_move()
#
#>
######################################################################
p6_date_math_move() {
    local date="$1"
    local offset="$2"
    local fmt_from="$3"
    local fmt_to="$4"

    date=$(p6_date_fmt__date "$date" "$fmt_from" "$fmt_to" "$offset")

    p6_return_date "$date"
}

######################################################################
#<
#
# Function: int delta = p6_date_math_delta_in_seconds(d1, d2, in_fmt)
#
#  Args:
#	d1 -
#	d2 -
#	in_fmt -
#
#  Returns:
#	int - delta
#
#>
######################################################################
p6_date_math_delta_in_seconds() {
    local d1="$1"
    local d2="$2"
    local in_fmt="$3"

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
#	d1 -
#	d2 -
#	fmt -
#
#  Returns:
#	float - delta_hours
#
#>
######################################################################
p6_date_math_delta_in_hours() {
    local d1="$1"
    local d2="$2"
    local fmt="$3"

    local delta_hours
    if p6_string_blank "$d1" || p6_string_blank "$d2"; then
        delta_hours=not_a_float
    else
        local delta_seconds=$(p6_date_math_delta_in_seconds "$d1" "$d2" "$fmt")
        delta_hours=$(p6_date_convert_seconds_to_hours "$delta_seconds")
    fi

    p6_return_float "$delta_hours"
}
