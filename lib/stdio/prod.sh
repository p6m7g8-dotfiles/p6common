######################################################################
#<
#
# Function: p6_prod_load()
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6_prod_load() {

  p6_file_load "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common/conf/prod/debug-prod.sh"
  p6_file_load "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common/conf/prod/log-prod.sh"
  p6_file_load "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common/conf/prod/time-prod.sh"
  p6_file_load "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common/conf/prod/trace-prod.sh"

  p6_return_void
}
