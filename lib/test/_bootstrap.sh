# XXX: DO NOT depend on anything
######################################################################
#<
#
# Function: p6_p6test_bootstrap([dir=$P6_DFZ_SRC_P6M7G8_DIR/p6test])
#
#  Args:
#	OPTIONAL dir - [$P6_DFZ_SRC_P6M7G8_DIR/p6test]
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DIR
#>
######################################################################
p6_p6test_bootstrap() {
  local dir="${1:-$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6test}"

  local file
  for file in $(find $dir -type f -name "*.sh" | xargs); do
    . "$file"
  done
}
