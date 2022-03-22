# shellcheck shell=bash

######################################################################
#<
#
# Function: str ip = p6_network_ip_public()
#
#  Returns:
#	str - ip
#
#>
######################################################################
p6_network_ip_public() {

  local ip
  ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

  p6_return_str "$ip"
}

