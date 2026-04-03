# shellcheck shell=bash

######################################################################
#<
#
# Function: str gnu_unit = p6_date_fmt___unit_char_to_gnu(unit_char)
#
#  Args:
#	unit_char - BSD -v unit character (d, m, y, H, M, S, w)
#
#  Returns:
#	str - gnu_unit
#
#>
#/ Synopsis
#/    Converts a BSD date -v unit character to a GNU date unit word.
######################################################################
p6_date_fmt___unit_char_to_gnu() {
    local unit_char="$1" # BSD -v unit character

    local gnu_unit
    case "$unit_char" in
        d) gnu_unit="day" ;;
        m) gnu_unit="month" ;;
        y) gnu_unit="year" ;;
        H) gnu_unit="hour" ;;
        M) gnu_unit="minute" ;;
        S) gnu_unit="second" ;;
        w) gnu_unit="week" ;;
        *) gnu_unit="$unit_char" ;;
    esac

    p6_return_str "$gnu_unit"
}

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

    local out_fmt
    if p6_string_blank "$output_fmt"; then
        out_fmt="%Y-%m-%d"
    else
        out_fmt="$output_fmt"
    fi

    local os_name
    os_name=$(p6_os_name)

    local dt
    case "$os_name" in
        Darwin|FreeBSD|OpenBSD|NetBSD)
            local cli_args=""
            if p6_string_blank_NOT "$offset"; then
                cli_args="$cli_args -v ${offset}${offset_fmt}"
            fi
            if p6_string_blank_NOT "$input_date"; then
                cli_args="$cli_args -j -f \"$input_fmt\" \"$input_date\""
            else
                cli_args="$cli_args -j"
            fi
            cli_args="$cli_args +\"$out_fmt\""
            dt=$(p6_date_fmt__cli "$cli_args")
            ;;
        *)
            [ -n "$offset_fmt" ] && offset="${offset}${offset_fmt}"
            local date_spec="$input_date"
            if p6_string_blank_NOT "$offset"; then
                local sign="${offset%"${offset#[+-]}"}"
                local rest="${offset#[+-]}"
                local num="${rest%%[a-zA-Z]*}"
                local unit_char="${rest#"$num"}"
                local gnu_unit
                gnu_unit=$(p6_date_fmt___unit_char_to_gnu "$unit_char")
                if p6_string_blank_NOT "$date_spec"; then
                    date_spec="$date_spec ${sign}${num} ${gnu_unit}"
                else
                    date_spec="${sign}${num} ${gnu_unit}"
                fi
            fi
            if p6_string_blank_NOT "$date_spec"; then
                dt=$(p6_date_fmt__cli "-d \"$date_spec\" +\"$out_fmt\"")
            else
                dt=$(p6_date_fmt__cli "+\"$out_fmt\"")
            fi
            ;;
    esac

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
