# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_network_http__debug(msg)
#
#  Args:
#	msg - debug message
#
#>
######################################################################
p6_network_http__debug() {
    local msg="$1" # debug message

    p6_debug "p6_network_http: $msg"

    p6_return_void
}

######################################################################
#<
#
# Function: str response = p6_network_http_post_basic_auth(url, creds)
#
#  Args:
#	url   - endpoint URL
#	creds - user:password for HTTP Basic auth
#
#  Returns:
#	str - response
#
#>
#/ Synopsis
#/    HTTP POST with Basic auth credentials; returns response body.
######################################################################
p6_network_http_post_basic_auth() {
    local url="$1"   # endpoint URL
    local creds="$2" # user:password for HTTP Basic auth

    local response
    response=$(curl -s -X POST "$url" -u "$creds")

    p6_network_http__debug "post_basic_auth(): $url"

    p6_return_str "$response"
}

######################################################################
#<
#
# Function: str response = p6_network_http_call(method, url, token, [data=])
#
#  Args:
#	method      - HTTP method (GET POST PATCH PUT DELETE)
#	url         - full request URL
#	token       - Bearer token
#	OPTIONAL data - JSON request body []
#
#  Returns:
#	str - response
#
#>
#/ Synopsis
#/    Authenticated REST call with optional JSON body; returns response body.
######################################################################
p6_network_http_call() {
    local method="$1" # HTTP method (GET POST PATCH PUT DELETE)
    local url="$2"    # full request URL
    local token="$3"  # Bearer token
    local data="${4:-}"

    local bearer="Authorization: Bearer ${token}"
    local ctype="Content-Type: application/json"

    local response
    response=$(curl -s -X "${method}" "$url" -H "$bearer" -H "$ctype" "${data:+-d}" "${data:+$data}")

    p6_network_http__debug "call(): ${method} $url"

    p6_return_str "$response"
}
