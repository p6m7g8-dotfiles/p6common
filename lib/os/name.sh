# shellcheck shell=bash

######################################################################
#<
#
# Function: str name = p6_os_name()
#
#  Returns:
#	str - name
#
#>
#/ Synopsis
#/    Returns the operating system name (uname -s).
######################################################################
p6_os_name() {

    p6_return_str "$(uname -s)"
}
