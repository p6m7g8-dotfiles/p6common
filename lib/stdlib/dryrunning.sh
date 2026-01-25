######################################################################
#<
#
# Function: bool rv = p6_dryrunning()
#
#  Returns:
#	bool - rv
#
#  Environment:	 P6_DRY_RUN
#>
#/ Synopsis
#/    Return true when dry-run mode is enabled.
######################################################################
p6_dryrunning() {

    p6_string_blank_NOT "$P6_DRY_RUN"
    local rv=$?

    p6_return_bool "$rv"
}
