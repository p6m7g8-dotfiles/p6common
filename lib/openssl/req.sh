# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_openssl_req_csr_create()
#
#  Environment:	 P6M7G8
#>
######################################################################
p6_openssl_req_csr_create() {
    local key_file="$1" # name of Key File (created)
    local csr_file="$2" # name of Certificate Signing Request file (created)
    local subject="$3"  # I.E:  "/C=US/ST=Maryland/L=Bowie/O=P6M7G8/OU=Technology/CN=p6m7g8.net"

    p6_run_read_cmd openssl req -nodes -newkey rsa:8192 -keyout "$key_file" -out "$csr_file" -subj "$subject"

    p6_return_void
}
