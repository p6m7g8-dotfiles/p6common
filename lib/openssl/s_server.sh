# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_openssl_s_server_run()
#
#>
#/ Synopsis
#/    Default port is 4433 to listen on
#/    Responds to a 'GET /' with a status page
#/
######################################################################
p6_openssl_s_server_run() {
    local key="$1" # path to the key file
    local crt="$2" # path to the certificate file
    shift 2        # additional openssl options

    openssl s_server -cert "$crt" -key "$key" -www "$@"
}
