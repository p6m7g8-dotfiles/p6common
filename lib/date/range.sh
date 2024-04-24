# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date_range_fill()
#
#>
######################################################################
p6_date_range_fill() {
    local start_date="$1"
    local end_date="$2"
    local file="$3"
    local fmt="$4"
    local sep="$5"

    local dates_file=$(p6_transient_create_file "p6.dates-fill")

    local date
    local total
    while read -r date total; do
        p6_echo "$date $total" >>"$dates_file"
    done <"$file"

    local current_date="$start_date"

    while ! p6_string_eq "$current_date" "$end_date"; do
        local line=$(p6_dt_range_fill__process "$current_date" "$dates_file")
        p6_echo "$line"

        current_date=$(p6_dt_move "$current_date" "+1d")
    done

    p6_date_range_fill__process "$end_date" "$dates_file" "$sep"

    p6_transient_delete "$dates_file"
}

######################################################################
#<
#
# Function: str line = p6_date_range_fill__process(current_date, dates_file, sep)
#
#  Args:
#	current_date -
#	dates_file -
#	sep -
#
#  Returns:
#	str - line
#
#>
######################################################################
p6_date_range_fill__process() {
    local current_date="$1"
    local dates_file="$2"
    local sep="$3"

    local value=0
    local line=$(p6_file_contains "$current_data" "$dates_file")
    if ! p6_string_blank "$line"; then
        value=$(p6_echo "$line" | p6_filter_column_pluck "2")
    fi

    local line="$current_date${sep}$value"

    p6_return_str "$line"
}
