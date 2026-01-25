######################################################################
#<
#
# Function: p6_diagnostics()
#
#>
#/ Synopsis
#/    Add this to a Jenkins Job to see stuff
#/    or kubectl exec -it --rm foo -- /bin/bash into and look around
#/
######################################################################
p6_diagnostics() {

    p6_msg "p6_diagnostics()"

    env | p6_filter_sort | p6_filter_row_select_regex '^GIT|^JENKINS|^DOCKER|PATH'
    pwd
    uname -a
    df -h
    uptime
    find . | p6_filter_row_exclude ".git/"

    p6_msg_success "p6_diagnostics()"
}
