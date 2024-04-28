# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_pgs()
#
#>
######################################################################
p6_pgs() {

	find . -type f | xargs perl -pi -e "s,$1,$2,g"

	p6_return_void
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
