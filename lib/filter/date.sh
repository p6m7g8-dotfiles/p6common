# shellcheck shell=bash

######################################################################
#<
#
# Function: filter  = p6_filter_translate_ms_epoch_to_iso8601_local()
#
#  Returns:
#	filter - 
#
#  Environment:	 MPOSIX
#>
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
#	column -
#	input_fmt -
#	ofs -
#	fs -
#
#  Returns:
#	filter - 
#
#  Environment:	 OFS STDIN
#>
######################################################################
p6_filter_translate_date_to_iso8601_utc() {
    local column="$1"
    local input_fmt="$2"
    local ofs="$3"
    local fs="$4"

    # preserve STDIN for filter pipe chain
    local line
    while read -r line; do
        if ! p6_string_blank "$line"; then
            # not utc
            local input_date=$(p6_echo "$line" | p6_filter_column_pluck "$column" "|")

            # convert to utc
            local date_utc=$(p6_date_fmt__date "$input_date" "$input_fmt" "%Y-%m-%dT%H:%M:%SZ")

            p6_echo "$line" | awk -v c="$column" -v v="$date_utc" -v OFS="$ofs" -v FS="$fs" '{ $c = v; print;}'
        fi
    done

    p6_return_filter
}
