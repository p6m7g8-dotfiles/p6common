# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_bootstrap()
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6_bootstrap() {
  local dir="${1:-$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common}"
  local islocal="${2:-}"

  local file
  for file in $(find -L "$dir/lib" -type f -a \( -name "*.sh" -o -name "*.zsh" \)); do
    . "$file"
  done

  p6_path_if "$dir/bin"

  p6_return_void
}
