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
######################################################################
p6_dryrunning() {

    test -n "${P6_DRY_RUN}"
    local rv=$?

    p6_return_bool "$rv"
}
