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

######################################################################
#<
#
# Function: p6df::modules::p6common::gha::ModuleDeps(module)
#
#  Args:
#	module -
#
#  Environment:	 M
#>
######################################################################
p6df::modules::p6common::gha::ModuleDeps() {
  local module="$1"

  . ./init.zsh
  p6df::modules::"${module}"::deps
  local dep
  local deps=$(
    for dep in $ModuleDeps; do
      echo $dep | cut -d: -f 1
    done | sort -u | grep -v p6common
  )

  local repo
  for repo in $(echo $deps); do
      git clone https://github.com/$repo
  done
}
