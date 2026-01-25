# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_bootstrap([dir=$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common], [islocal=])
#
#  Args:
#	OPTIONAL dir - library root to load [$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common]
#	OPTIONAL islocal - unused flag for local bootstrap []
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
#/ Synopsis
#/    Loads p6common library files from dir and adds its bin to PATH.
######################################################################
p6_bootstrap() {
  local dir="${1:-$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common}" # library root to load
  local islocal="${2:-}"                                     # unused flag for local bootstrap

  local file
  for file in $(find -L "$dir/lib" -type f -a \( -name "*.sh" -o -name "*.zsh" \)); do
    . "$file"
  done

  p6_path_if "$dir/bin"

  p6_return_void
}
