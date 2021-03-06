# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_remote__debug()
#
#>
######################################################################
p6_remote__debug() {
  local msg="$1"

  p6_debug "p6_remote: $msg"

  p6_return_void
}

######################################################################
#<
#
# Function: p6_remote_ssh_do(cmd)
#
#  Args:
#	cmd -
#
#>
######################################################################
p6_remote_ssh_do() {
  local cmd="$1"

  p6_run_read_cmd $cmd

  p6_return_void
}
