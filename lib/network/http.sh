# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_curl(...)
#
#  Args:
#	... - curl arguments
#
#>
#/ Synopsis
#/    Thin wrapper around curl; all callers build their own args.
######################################################################
p6_curl() {
    shift 0

    p6_log "curl $*"
    curl "$@"

    p6_return_void
}

######################################################################
#<
#
# Function: str response = p6_network_http_post_basic_auth(url, creds, ...)
#
#  Args:
#	url   - endpoint URL
#	creds - user:password for HTTP Basic auth
#	...   - additional curl args (e.g. -H "Header: value")
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
    shift 2          # additional curl args

    local response
    response=$(p6_curl -s -X POST "$url" -u "$creds" "$@")

    p6_return_str "$response"
}

######################################################################
#<
#
# Function: str response = p6_network_http_call(method, url, token, [data=], ...)
#
#  Args:
#	method      - HTTP method (GET POST PATCH PUT DELETE)
#	url         - full request URL
#	token       - Bearer token
#	OPTIONAL data - JSON request body []
#	...         - additional curl args (e.g. -H "Header: value")
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
    shift 4           # additional curl args

    local bearer="Authorization: Bearer ${token}"
    local ctype="Content-Type: application/json"

    local response
    response=$(p6_curl -s -X "${method}" "$url" -H "$bearer" -H "$ctype" "${data:+-d}" "${data:+$data}" "$@")

    p6_return_str "$response"
}
