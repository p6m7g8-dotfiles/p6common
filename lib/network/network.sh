# shellcheck shell=bash

######################################################################
#<
#
# Function: ipv4 ip = p6_network_ip_public()
#
#  Returns:
#	ipv4 - ip
#
#>
######################################################################
p6_network_ip_public() {

  local ip
  ip=$(curl -fsS http://ifconfig.me)

  p6_return_ipv4 "$ip"
}
