# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_openssl_req_cert_self_signed_create(key_file, csr_file, [cert_exp=365])
#
#  Args:
#	key_file - private key file
#	csr_file - CSR file
#	OPTIONAL cert_exp - certificate expiration in days [365]
#
#>
#/ Synopsis
#/    Generates a self-signed certificate from a CSR and key.
######################################################################
p6_openssl_req_cert_self_signed_create() {
    local key_file="$1"    # private key file
    local csr_file="$2"    # CSR file
    local cert_exp="${3:-365}" # certificate expiration in days

    openssl x509 -req -in "$csr_file" -signkey "$key_file" -days "$cert_exp"
}
