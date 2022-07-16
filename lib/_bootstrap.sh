# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_bootstrap()
#
#  Environment:	 EPOCHREALTIME P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6_bootstrap() {
  local dir="${1:-$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common}"
  local islocal="${2:-}"

  local t0=$EPOCHREALTIME
  local file
  for file in $(find "$dir/lib" -type f); do
    . "$file"
  done
  local t1=$EPOCHREALTIME
  p6_time "$t0" "$t1" "p6_dir_load($dir)"

  p6_path_if "$dir/bin"

  p6_return_void
}
