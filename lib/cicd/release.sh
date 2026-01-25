# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cicd_release_make()
#
#>
#/ Synopsis
#/    Creates a standard-version release and pushes tags to origin.
######################################################################
p6_cicd_release_make() {

    if p6_string_contains "$(git log --oneline -1)" "chore(release):"; then
        p6_return_code_as_code 0
    fi

    npx standard-version

    git push --follow-tags origin master
}
