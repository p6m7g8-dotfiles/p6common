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
    local amount="$2"
    local fmt_from="$3"
    local fmt_to="$3"

    current_date=$(p6_dt__date "$fmt_top" "$amount" "$fmt_to" "$current_date")

    p6_return_date "$current_date"
}

######################################################################
#<
#
# Function: int delta = p6_date_math_delta(d1, d2, in_fmt, [out_fmt=%s])
#
#  Args:
#	d1 -
#	d2 -
#	in_fmt -
#	OPTIONAL out_fmt - [%s]
#
#  Returns:
#	int - delta
#
#>
######################################################################
p6_date_math_delta() {
    local d1="$1"
    local d2="$2"
    local in_fmt="$3"
    local out_fmt="${4:-%s}"

    local d1s=$(p6_date__date "$out_fmt" "${d1}" "$in_fmt")
    local d2s=$(p6_date__date "$out_fmt" "${d2}" "$in_fmt")

    local delta=$(p6_math_sub "$d2s" "$d1s")

    p6_return_int "$delta"
}
