# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date_fmt__date(input_date, input_fmt, output_fmt, offset, offset_fmt)
#
#  Args:
#	input_date - input date string
#	input_fmt - input format
#	output_fmt - output format
#	offset - offset expression
#	offset_fmt - offset format suffix
#
#>
#/ Synopsis
#/    Calculates and returns a date string adjusted by a specified offset
#/    from a given date or the current date, formatted according to the
#/    specified format.
######################################################################
p6_date_fmt__date() {
    local input_date="$1" # input date string
    local input_fmt="$2"  # input format
    local output_fmt="$3" # output format
    local offset="$4"     # offset expression
    local offset_fmt="$5" # offset format suffix

    local cli_args=""

    # Applies offset
    if ! p6_string_blank "$offset"; then
        cli_args="$cli_args -v ${offset}${offset_fmt}"
    fi

    if ! p6_string_blank "$input_date"; then
        cli_args="$cli_args -j -f \"$input_fmt\" \"$input_date\""
    else
        cli_args="$cli_args -j"
    fi

    # Set output format
    if p6_string_blank "$output_fmt"; then
        cli_args="$cli_args +\"%Y-%m-%d\""
    else
        cli_args="$cli_args +\"$output_fmt\""
    fi

    local dt=$(p6_date_fmt__cli "$cli_args")

    p6_date__debug "__date(): input_date=$input_date input_fmt=$input_fmt output_fmt=$output_fmt offset=$offset offset_fmt=$offset_fmt -> $dt"

    p6_return_date "$dt"
}

######################################################################
#<
#
# Function: p6_date_fmt__cli(...)
#
#  Args:
#	... - date(1) arguments
#
#>
#/ Synopsis
#/    Executes the system date command with the provided arguments.
######################################################################
p6_date_fmt__cli() {
    shift 0 # date(1) arguments

    p6_run_code "date" "$@"
}

######################################################################
#<
#
# Function: p6_date_fmt_relative_to_absolute(relative)
#
#  Args:
#	relative - relative duration string
#
#>
#/ Synopsis
#/    Converts a relative duration (e.g. "3 days") to an absolute date.
######################################################################
p6_date_fmt_relative_to_absolute() {
    local relative="$1" # relative duration string

    local number=$(p6_echo "$relative" | p6_filter_column_pluck "1")
    local unit=$(p6_echo "$relative" | p6_filter_column_pluck "2")
    local unit_abbr=$(p6_echo "$unit" | p6_filter_string_first_character)

    local absolute=$(p6_date_fmt__date "" "" "%Y-%m-%d" "-${number}${unit_abbr}" "")

    p6_return_date "$absolute"
}
