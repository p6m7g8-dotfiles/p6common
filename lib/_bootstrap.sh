# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_bootstrap([dir=$P6_DFZ_SRC_P6M7G8_DIR/p6common], [islocal=])
#
#  Args:
#	OPTIONAL dir - [$P6_DFZ_SRC_P6M7G8_DIR/p6common]
#	OPTIONAL islocal - []
#
#  Depends:	 p6_bootstrap p6_file p6_path p6_time
#  Environment:	 EPOCHREALTIME P6_DFZ_SRC_P6M7G8_DIR
#>
######################################################################
p6_bootstrap() {
  local dir="${1:-$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common}"
  local islocal="${2:-}"

  p6_bootstrap_optimize "$dir" "$islocal"

  local t0=$EPOCHREALTIME
  local file
  for file in $(p6_dir_list_recursive "$dir/lib"); do
    p6_file_load "$file"
  done
  local t1=$EPOCHREALTIME
  p6_time "$t0" "$t1" "p6_dir_load($dir)"

  p6_path_if "$dir/bin"

  p6_return_void
}

# this trims .3s
######################################################################
#<
#
# Function: p6_bootstrap_optimize(dir, islocal)
#
#  Args:
#	dir -
#	islocal -
#
#  Environment:	 XXX
#>
######################################################################
p6_bootstrap_optimize() {
  local dir="$1"
  local islocal="$2"

  if [ x"$islocal" != x"local" ]; then
    # XXX: Chicken in Egg....
    . $dir/../p6common/lib/stdlib/const.sh
    . $dir/../p6common/lib/types/return.sh
    . $dir/../p6common/lib/stdio/io.sh
    . $dir/../p6common/lib/stdio/debug.sh
    . $dir/../p6common/lib/string/string.sh
    . $dir/../p6common/lib/stdio/file.sh
    . $dir/../p6common/lib/stdio/dir.sh
  elif [ x"islocal" = x"github" ]; then
    . $dir/lib/stdlib/const.sh
    . $dir/lib/types/return.sh
    . $dir/lib/stdio/io.sh
    . $dir/lib/stdio/debug.sh
    . $dir/lib/string/string.sh
    . $dir/lib/stdio/file.sh
    . $dir/lib/stdio/dir.sh
  fi
}
