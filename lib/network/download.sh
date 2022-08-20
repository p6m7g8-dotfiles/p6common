# shellcheck shell=bash

######################################################################
#<
#
# Function: path dest = p6_network_file_download()
#
#  Returns:
#	path - dest
#
#>
######################################################################
p6_network_file_download() {
    local url="$1"
    local dest="$2"
    shift 2

    curl -fsS -L -o "$dest" "$url"

    p6_return_path "$dest"
}
