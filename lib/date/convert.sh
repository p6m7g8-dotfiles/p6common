# shellcheck shell=bash

######################################################################
#<
#
# Function: float hours = p6_date_convert_seconds_to_hours(seconds, [scale=3])
#
#  Args:
#	seconds - The seconds to convert
#	OPTIONAL scale - Default scale is 3 if not provided [3]
#
#  Returns:
#	float - hours
#
#  Environment:	 SECONDS_PER_HOUR
#>
#/ Synopsis
#/    Converts seconds to hours with the requested decimal scale.
######################################################################
p6_date_convert_seconds_to_hours() {
    local seconds="$1"    # The seconds to convert
    local scale="${2:-3}" # Default scale is 3 if not provided

    local format="%."${scale}"f" # Creates a format string like "%.2f"
    local SECONDS_PER_HOUR=3600  # Defining the constant

    local hours=$(awk -v scale="$scale" -v seconds="$seconds" -v sp_hour="$SECONDS_PER_HOUR" -v format="$format" 'BEGIN { scale=scale; printf format "\n", seconds / sp_hour }')

    p6_return_float "$hours"
}

######################################################################
#<
#
# Function: str str = p6_date_convert_ms_epoch_to_local(ms_epoch)
#
#  Args:
#	ms_epoch - milliseconds since epoch
#
#  Returns:
#	str - str
#
#>
#/ Synopsis
#/    Converts milliseconds since epoch to a local ISO8601 string.
######################################################################
p6_date_convert_ms_epoch_to_local() {
    local ms_epoch="$1" # milliseconds since epoch

    local str=$(p6_echo "$ms_epoch" | p6_filter_translate_ms_epoch_to_iso8601_local)

    p6_return_str "$str"
}
