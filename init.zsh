# shellcheck shell=bash

######################################################################
#<
#
# Function: p6df::modules::p6common::init()
#
#>
######################################################################
p6df::modules::p6common::init() {
    local _module="$1"
    local dir="$2"

  . $dir/lib/_bootstrap.sh
  p6_bootstrap "$dir"

  p6_path_if "$dir/bin"
}
