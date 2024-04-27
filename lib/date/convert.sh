# shellcheck shell=bash

######################################################################
#<
#
# Function: float hours = p6_date_convert_seconds_to_hours()
#
#  Returns:
#	float - hours
#
#  Environment:	 SECONDS_PER_HOUR
#>
######################################################################
p6_date_convert_seconds_to_hours() {
    local seconds="$1"    # The seconds to convert
    local scale="${2:-2}" # Default scale is 2 if not provided

    local format="%."${scale}"f" # Creates a format string like "%.2f"
    local SECONDS_PER_HOUR=3600  # Defining the constant

    local hours=$(awk -v scale="$scale" -v seconds="$seconds" -v sp_hour="$SECONDS_PER_HOUR" -v format="$format" 'BEGIN { scale=scale; printf format "\n", seconds / sp_hour }')

    p6_return_float "$hours"
}
