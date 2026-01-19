# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cicd_doc_gen()
#
#  Environment:	 _
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
		doc_inline.pl --module "$module"
		doc_readme.pl --module "$module" >$module/README.md
	)
}
