# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_pgs()
#
#>
#/ Synopsis
#/    Find and replace a pattern across files under the current tree.
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
#>
#/ Synopsis
#/    Delete common editor and backup junk files under the tree.
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
