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
# Function: str dt = p6_dt__date(fmt, [offset=], [offset_fmt=], [date=])
#
#  Args:
#	fmt - Output format
#	OPTIONAL offset - i.e. +1d -2w []
#	OPTIONAL offset_fmt - Format of `date` i.e. %Y-%m-%d []
#	OPTIONAL date - current date if blank []
#
#  Returns:
#	str - dt
#
#>
#/ Synopsis
#/    Calculates and returns a date string adjusted by a specified offset
#/    from a given date or the current date, formatted according to the
#/    specified format.
######################################################################
p6_dt__date() {
    local fmt="$1"            # Output format
    local offset="${2:-}"     # i.e. +1d -2w
    local offset_fmt="${3:-}" # Format of `date` i.e. %Y-%m-%d
    local date="${4:-}"       # current date if blank

    p6_dt__debug "_date(): date \"$fmt\" \"$offset\" \"$offset_fmt\" \"$date\""

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

    p6_dt__debug "_date(): date \"$dt\""

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
# Function: str hours = p6_dt_seconds_to_hours(seconds)
#
#  Args:
#	seconds -
#
#  Returns:
#	str - hours
#
#  Environment:	 XXX
#>
######################################################################
p6_dt_seconds_to_hours() {
    local seconds="$1"

    local hours=$(p6_echo "scale=2; $seconds / 3600" | bc -lq)
    # XXX: sometimes we get an int above

    p6_return_str "$hours"
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

    local number=$(p6_echo "$relative" | p6_filter_column_pluck "1")
    local unit=$(p6_echo "$relative" | p6_filter_column_pluck "2")

    local unit_abbr=$(p6_echo "$unit" | p6_filter_first_character)

    local absolute=$(p6_dt__date "%Y-%m-%d" "-${number}${unit_abbr}")

    p6_return_str "$absolute"
}

######################################################################
#<
#
# Function: p6_dt_range_fill(start_date, end_date, file, fmt, sep)
#
#  Args:
#	start_date -
#	end_date -
#	file -
#	fmt -
#	sep -
#
#>
######################################################################
p6_dt_range_fill() {
    local start_date="$1"
    local end_date="$2"
    local file="$3"
    local fmt="$4"
    local sep="$5"

    local dates_file=$(p6_transient_create_file "p6.dt_fill_range.txt")

    local date
    local total
    while read -r date total; do
        p6_echo "$date $total" >>"$dates_file"
    done <"$file"

    local current_date="$start_date"

    while ! p6_string_eq "$current_date" "$end_date"; do
        p6_dt_range_fill__process "$current_date" "$dates_file"
        current_date=$(p6_dt_move "$current_date" "+1d")
    done

    p6_dt_range_fill__process "$end_date" "$dates_file" "$sep"

    p6_transient_delete "$dates_file"
}

######################################################################
#<
#
# Function: str current_date = p6_dt_move(date, amount, fmt_from, fmt_to)
#
#  Args:
#	date -
#	amount -
#	fmt_from -
#	fmt_to -
#
#  Returns:
#	str - current_date
#
#>
######################################################################
p6_dt_move() {
    local date="$1"
    local amount="$2"
    local fmt_from="$3"
    local fmt_to="$3"

    current_date=$(p6_dt__date "$fmt_top" "$amount" "$fmt_to" "$current_date")

    p6_return_str "$current_date"
}

######################################################################
#<
#
# Function: p6_dt_range_fill__process(current_date, dates_file, sep)
#
#  Args:
#	current_date -
#	dates_file -
#	sep -
#
#>
######################################################################
p6_dt_range_fill__process() {
    local current_date="$1"
    local dates_file="$2"
    local sep="$3"

    local value=0
    local line=$(p6_file_contains "$current_data" "$dates_file")
    if ! p6_string_blank "$line"; then
        value=$(p6_echo "$line" | p6_filter_column_pluck "2")
    fi

    p6_echo "$current_date${sep}$value"
}
