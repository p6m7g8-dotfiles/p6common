# shellcheck shell=bash

######################################################################
#<
#
# Function: p6df::modules::p6common::init()
#
#>
######################################################################
p6df::modules::p6common::init() {

  . $__p6_dir/lib/_bootstrap.sh
  p6_bootstrap "$__p6_dir"
}
