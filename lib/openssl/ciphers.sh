# shellcheck shell=bash

######################################################################
#<
#
# Function: str str = p6_openssl_ciphers()
#
#  Returns:
#	str - str
#
#>
#/ Synopsis
#/    Shows the supported Ciphers
#/
######################################################################
p6_openssl_ciphers() {

    local str
    str=$(openssl ciphers -v)

    p6_return_str "$str"
}
