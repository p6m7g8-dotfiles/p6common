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
#/ Synopsis
#/    Returns the output of `openssl version -a`.
######################################################################
p6_openssl_version() {

    local str
    str=$(openssl version -a)

    p6_return_str "$str"
}
