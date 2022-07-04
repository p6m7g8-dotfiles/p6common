# shellcheck shell=bash

######################################################################
#<
#
# Function: code  = p6_cicd_release_make()
#
#  Returns:
#	code - 
#
#>
######################################################################
p6_cicd_release_make() {

    if git log --oneline -1 | grep -q "chore(release):"; then
        p6_return_code_as_code 0
    fi

    npx standard-version

    git push --follow-tags origin master
}
