# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_openssl_certificate_create()
#
#>
#/ Synopsis
#/   Geenrates key_file, csr_file, and outputs certificate to stdout
#/
######################################################################
p6_openssl_certificate_create() {
    local key_file="$1"        # name of Key File (created)
    local csr_file="$2"        # name of Certificate Signing Request file (created)
    local subject="$3"         # I.E:  "/C=US/ST=Maryland/L=Bowie/O=P6M7G8/OU=Technology/CN=p6m7g8.net"
    local cert_exp="${4:-365}" # Ceritificate Expiration in days

    p6_openssl_req_csr_create "$key_file" "$csr_file" "$subject"
    p6_openssl_req_cert_self_signed_create "$key_file" "$csr_file" "$cert_exp"

    p6_return_void
}
