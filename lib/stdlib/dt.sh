# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_dt__debug()
#
#>
######################################################################
p6_dt__debug() {
    local msg="$1"

    p6_debug "p6_dt: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: str dt = p6_dt__date(fmt, [offset=], [offset_fmt=])
#
#  Args:
#	fmt -
#	OPTIONAL offset - []
#	OPTIONAL offset_fmt - []
#
#  Returns:
#	str - dt
#
#>
######################################################################
p6_dt__date() {
    local fmt="$1"
    local offset="${2:-}"
    local offset_fmt="${3:-}"

    p6_dt__debug "_date(): date \"$fmt\" \"$offset\" \"$offset_fmt\""

    local dt
    if p6_string_blank "$offset"; then
        dt=$(date "+$fmt")
    else
        if p6_string_blank "$offset_fmt"; then
            dt=$(date -v "$offset" "+$fmt")
        else
            dt=$(date -j -f "$offset_fmt" "$offset" "+$fmt")
        fi
    fi

    p6_return_str "$dt"
}

######################################################################
#<
#
# Function: size_t epoch_seconds = p6_dt_now_epoch_seconds()
#
#  Returns:
#	size_t - epoch_seconds
#
#>
######################################################################
p6_dt_now_epoch_seconds() {

    local epoch_seconds=$(p6_dt__date "+%s")

    p6_return_size_t "$epoch_seconds"
}

######################################################################
#<
#
# Function: str dt = p6_dt_now()
#
#  Returns:
#	str - dt
#
#>
######################################################################
p6_dt_now() {

    local dt=$(p6_dt__date "+%Y%m%d")

    p6_return_str "$dt"
}

######################################################################
#<
#
# Function: str dt = p6_dt_yesterday()
#
#  Returns:
#	str - dt
#
#>
######################################################################
p6_dt_yesterday() {

    local fmt="+%Y%m%d"

    local dt=$(p6_dt__date "$fmt" "-1d")

    p6_return_str "$dt"
}

######################################################################
#<
#
# Function: str dt = p6_dt_tomorrow()
#
#  Returns:
#	str - dt
#
#>
######################################################################
p6_dt_tomorrow() {

    local fmt="+%Y%m%d"

    local dt=$(p6_dt__date "$fmt" "1d")

    p6_return_str "$dt"
}

######################################################################
#<
#
# Function: size_t modified_epoch_seconds = p6_dt_mtime(file)
#
#  Args:
#	file -
#
#  Returns:
#	size_t - modified_epoch_seconds
#
#>
######################################################################
p6_dt_mtime() {
    local file="$1"

    local modified_epoch_seconds=$(stat -f "%m" $file)

    p6_return_size_t "$modified_epoch_seconds"
}

######################################################################
#<
#
# Function: int delta = p6_dt_delta_in_seconds(d1, d2, fmt)
#
#  Args:
#	d1 -
#	d2 -
#	fmt -
#
#  Returns:
#	int - delta
#
#>
######################################################################
p6_dt_delta_in_seconds() {
    local d1="$1"
    local d2="$2"
    local fmt="$3"

    local d1s=$(p6_dt__date "%s" "${d1}" "$fmt")
    local d2s=$(p6_dt__date "%s" "${d2}" "$fmt")

    local delta=$(p6_math_sub "$d2s" "$d1s")

    p6_return_int "$delta"
}

######################################################################
#<
#
# Function: p6_dt_seconds_to_hours(seconds)
#
#  Args:
#	seconds -
#
#>
######################################################################
p6_dt_seconds_to_hours() {
    local seconds="$1"

    local hours=$(p6_echo "scale=2; $seconds / 3600" | bc -lq)

    p6_return_float "$hours"
}

######################################################################
#<
#
# Function: str absolute = p6_dt_relative_to_absolute(relative)
#
#  Args:
#	relative -
#
#  Returns:
#	str - absolute
#
#>
######################################################################
p6_dt_relative_to_absolute() {
    local relative="$1"

    local number=$(p6_echo "$relative" | awk '{print $1}')
    local unit=$(p6_echo "$relative" | awk '{print $2}')

    local unit_abbr=$(p6_echo "$unit" | cut -c 1)

    local absolute=$(p6_dt__date "%Y-%m-%d" "-${number}${unit_abbr}")

    p6_return_str "$absolute"
}
