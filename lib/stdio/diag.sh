######################################################################
#<
#
# Function: p6_diagnostics()
#
#  Environment:	 GIT
#>
#/ Synopsis
#/    Add this to a Jenkins Job to see stuff
#/    or kubectl exec -it --rm foo -- /bin/bash into and look around
#/
######################################################################
p6_diagnostics() {

    p6_msg "p6_diagnostics()"

    env | sort | grep -E '^GIT|^JENKINS|^DOCKER|PATH'
    pwd
    uname -a
    df -h
    uptime
    find . | grep -v .git/

    p6_msg_success "p6_diagnostics()"
}
