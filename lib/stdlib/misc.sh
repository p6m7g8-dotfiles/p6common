# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_pgs()
#
#  Depends:	 p6_len p6_xclean
#>
######################################################################
p6_pgs() {

	find . -type f | xargs perl -pi -e "s,$1,$2,g"

	p6_return_void
}

#XXX: duped in string
######################################################################
#<
#
# Function: size_t len = p6_len(s)
#
#  Args:
#	s -
#
#  Returns:
#	size_t - len
#
#  Depends:	 p6_xclean
#>
######################################################################
p6_len() {
	local s="$1"

	local len="${#s}"

	p6_return_size_t "$len"
}

######################################################################
#<
#
# Function: p6_xclean()
#
#  Environment:	 DS_S
#>
######################################################################
p6_xclean() {

	find . \( -type f -o -type l \) -a \
		\( \
		-name ".DS_Store" -o \
		-name "*.bak" -o \
		-name "*~" -o \
		-name ".\#*" -o \
		-name "\#*" -o \
		-name "*.rej" -o \
		-name "svn-commit.*" -o \
		-name "*.orig" -o \
		-name "*-i" -o \
		-name "*.tmp" -o \
		-name "=~+*" \
		\) \
		-print -exec rm -f "{}" \;

	p6_return_void
}
