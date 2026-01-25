# shellcheck shell=bash

######################################################################
#<
#
# Function: stream  = p6_date_range_fill(start_date, end_date, file, fmt, [sep=])
#
#  Args:
#	start_date - first date (inclusive)
#	end_date - last date (inclusive)
#	file - input file of date/value rows
#	fmt - date format (unused)
#	OPTIONAL sep - column separator []
#
#  Returns:
#	stream - 
#
#>
#/ Synopsis
#/    Fills missing dates between start and end with zero values from a file.
######################################################################
p6_date_range_fill() {
    local start_date="$1" # first date (inclusive)
    local end_date="$2"   # last date (inclusive)
    local file="$3"       # input file of date/value rows
    local fmt="$4"        # date format (unused)
    local sep="${5:-}"    # column separator
    if p6_string_blank "$sep"; then
        sep=$'\t'
    fi

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
# Function: str line = p6_date_range_fill__process(date, dates_file, [sep=])
#
#  Args:
#	date - date to process
#	dates_file - file of date/value rows
#	OPTIONAL sep - column separator []
#
#  Returns:
#	str - line
#
#>
#/ Synopsis
#/    Builds a single date/value line from the date list and separator.
######################################################################
p6_date_range_fill__process() {
    local date="$1"       # date to process
    local dates_file="$2" # file of date/value rows
    local sep="${3:-}"    # column separator
    if p6_string_blank "$sep"; then
        sep=$'\t'
    fi

    local value=0
    local line=$(p6_file_contains "$date" "$dates_file")
    if ! p6_string_blank "$line"; then
        value=$(p6_echo "$line" | p6_filter_column_pluck "2")
    fi

    local line="$date${sep}$value"

    p6_return_str "$line"
}
