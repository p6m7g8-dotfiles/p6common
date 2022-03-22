# shellcheck shell=bash

######################################################################
#<
#
# Function: str str = p6_openssl_version()
#
#  Returns:
#	str - str
#
#>
######################################################################
p6_openssl_version() {

    local str
    str=$(openssl version -a)

    p6_return_str "$str"
}
