# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_date_convert_seconds_to_hours()
#
#  Environment:	 SECONDS_PER_HOUR
#>
######################################################################
p6_date_convert_seconds_to_hours() {
    local seconds="$1"
    local scale="${2:-2}"        # Default scale is 2 if not provided
    local format="%."${scale}"f" # Creates a format string like "%.2f"
    local SECONDS_PER_HOUR=3600  # Defining the constant

    local hours=$(awk -v seconds="$seconds" -v sp_hour="$SECONDS_PER_HOUR" -v fmt="$format" 'BEGIN { printf "scale="scale"; " fmt "\n", seconds / sp_hour }')

    p6_return_float "$hours"
}
