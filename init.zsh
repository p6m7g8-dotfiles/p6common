# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::p6common::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#>
######################################################################
p6df::modules::p6common::init() {
    local _module="$1"
    local dir="$2"

  . $dir/lib/_bootstrap.sh
  p6_bootstrap "$dir"

  p6_path_if "$dir/bin"

  p6_return_void
}
