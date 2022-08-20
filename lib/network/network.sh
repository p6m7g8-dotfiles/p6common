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
  ip=$(curl -fsS http://ifconfig.me)

  p6_return_str "$ip"
}
