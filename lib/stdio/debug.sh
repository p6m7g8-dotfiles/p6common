######################################################################
#<
#
# Function: p6_debug_load()
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6_debug_load() {

  p6_file_load "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common/conf/debug/debug-debug.sh"
  p6_file_load "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common/conf/debug/log-debug.sh"
  p6_file_load "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common/conf/debug/time-debug.sh"
  p6_file_load "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common/conf/debug/trace-debug.sh"

  p6_return_void
}
