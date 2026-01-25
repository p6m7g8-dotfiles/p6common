# shellcheck shell=bash

######################################################################
#<
#
# Function: path dest = p6_network_file_download(url, dest, ...)
#
#  Args:
#	url - source URL
#	dest - destination file path
#	... - unused extra args
#
#  Returns:
#	path - dest
#
#>
#/ Synopsis
#/    Downloads a URL to a destination file.
######################################################################
p6_network_file_download() {
    local url="$1"  # source URL
    local dest="$2" # destination file path
    shift 2         # unused extra args

    curl -fsS -L -o "$dest" "$url"

    p6_return_path "$dest"
}
