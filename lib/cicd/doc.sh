# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cicd_doc_gen()
#
#  Environment:	 README
#>
######################################################################
p6_cicd_doc_gen() {

	local _p6_cwd
	_p6_cwd=$(pwd)

	local module
	module=$(basename "$_p6_cwd")

	(
		cd ..
		set -x
		perl p6perl/bin/doc_inline.pl --module "$module"
		perl p6perl/bin/doc_readme.pl --module "$module" >$module/README.md
	)
}
