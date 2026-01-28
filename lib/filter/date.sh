# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_translate_ms_epoch_to_iso8601_local()
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Convert millisecond epoch values to local ISO8601 timestamps.
######################################################################
p6_filter_translate_ms_epoch_to_iso8601_local() {

   perl -MPOSIX -pe 'if (/(\d+)/) { $t = $1 / 1000; s/\d+/strftime("%Y-%m-%d %H:%M:%S %Z", localtime($t))/e }'

   p6_return_filter
}

######################################################################
#<
#
# Function: filter  = p6_filter_translate_date_to_iso8601_utc(column, input_fmt, ofs, fs)
#
#  Args:
#	column - column index
#	input_fmt - input date format
#	ofs - output field separator
#	fs - input field separator
#
#  Returns:
#	filter - 
#
#>
#/ Synopsis
#/    Replace a date column with UTC ISO8601 timestamps.
######################################################################
p6_filter_translate_date_to_iso8601_utc() {
    local column="$1"    # column index
    local input_fmt="$2" # input date format
    local ofs="$3"       # output field separator
    local fs="$4"        # input field separator

    # preserve STDIN for filter pipe chain
    local line
    while read -r line; do
        if p6_string_blank_NOT "$line"; then
            # not utc
            local input_date=$(p6_echo "$line" | p6_filter_column_pluck "$column" "|")

            # convert to utc
            local date_utc=$(p6_date_fmt__date "$input_date" "$input_fmt" "%Y-%m-%dT%H:%M:%SZ")

            p6_echo "$line" | awk -v c="$column" -v v="$date_utc" -v OFS="$ofs" -v FS="$fs" '{ $c = v; print;}'
        fi
    done

    p6_return_filter
}
