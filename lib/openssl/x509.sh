# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_openssl_req_cert_self_signed_create()
#
#>
######################################################################
p6_openssl_req_cert_self_signed_create() {
    local key_file="$1"
    local csr_file="$2"
    local cert_exp="${3:-365}"

    openssl x509 -req -in "$csr_file" -signkey "$key_file" -days "$cert_exp"
}
