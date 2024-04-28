# shellcheck shell=bash

######################################################################
#<
#
# Function: stream  = p6_date_range_fill()
#
#  Returns:
#	stream - 
#
#>
######################################################################
p6_date_range_fill() {
    local start_date="$1"
    local end_date="$2"
    local file="$3"
    local fmt="$4"
    local sep="${5:-\t}"

    local dates_file=$(p6_transient_create_file "p6.dates-fill")

    local date
    local total
    while read -r date total; do
        p6_echo "$date $total" >>"$dates_file"
    done <"$file"

    local current_date="$start_date"

    while ! p6_string_eq "$current_date" "$end_date"; do
        local line=$(p6_date_range_fill__process "$current_date" "$dates_file" "$sep")
        p6_echo -e "$line"

        current_date=$(p6_date_math_move "$current_date" "+1d" "%Y-%m-%d" "%Y-%m-%d")
    done

    local last_line=$(p6_date_range_fill__process "$end_date" "$dates_file" "$sep")
    p6_echo -e "$last_line"

    p6_transient_delete "$dates_file"

    p6_return_stream
}

######################################################################
#<
#
# Function: str line = p6_date_range_fill__process(date, dates_file, [sep=\t])
#
#  Args:
#	date -
#	dates_file -
#	OPTIONAL sep - [\t]
#
#  Returns:
#	str - line
#
#>
######################################################################
p6_date_range_fill__process() {
    local date="$1"
    local dates_file="$2"
    local sep="${3:-\t}"

    local value=0
    local line=$(p6_file_contains "$date" "$dates_file")
    if ! p6_string_blank "$line"; then
        value=$(p6_echo "$line" | p6_filter_column_pluck "2")
    fi

    local line="$date${sep}$value"

    p6_return_str "$line"
}
