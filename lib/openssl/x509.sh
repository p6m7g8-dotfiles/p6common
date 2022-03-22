# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_openssl_req_cert_self_signed_create(key_file, csr_file, [cert_exp=365])
#
#  Args:
#	key_file -
#	csr_file -
#	OPTIONAL cert_exp - [365]
#
#>
######################################################################
p6_openssl_req_cert_self_signed_create() {
    local key_file="$1"
    local csr_file="$2"
    local cert_exp="${3:-365}"

    openssl x509 -req -in "$csr_file" -signkey "$key_file" -days "$cert_exp"
}
