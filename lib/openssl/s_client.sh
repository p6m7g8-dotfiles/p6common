# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_openssl_s_client_connect(host, [port=443], ...)
#
#  Args:
#	host - FQDN of the website
#	OPTIONAL port - TCP port [443]
#	... - additional openssl options
#
#>
#/ Synopsis
#/    Connects to $host on $port and returns the SSL Cert
#/    This already redirected to STDOUT
#/    Additional openssl options can be passed
#/    SSL is not allowed, only TLSv1+
######################################################################
p6_openssl_s_client_connect() {
    local host="$1"        # FQDN of the website
    local port="${2:-443}" # TCP port
    shift 2                # additional openssl options

    echo "" | openssl s_client -connect -servername "${host}" "${host}":"${port}" -tls1 "$@" 2>&1
}

######################################################################
#<
#
# Function: p6_openssl_not_after(host, port, ...)
#
#  Args:
#	host - FQDN of the website
#	port - TCP port
#	... - additional openssl options
#
#>
#/ Synopsis
#/    Prints the certificate notAfter date from a TLS server.
######################################################################
p6_openssl_not_after() {
    local host="$1" # FQDN of the website
    local port="$2" # TCP port
    shift 2         # additional openssl options

    p6_openssl_s_client_connect "$host" "$port" "$@" | openssl x509 -noout -enddate
}

######################################################################
#<
#
# Function: p6_openssl_not_before(host, port, ...)
#
#  Args:
#	host - FQDN of the website
#	port - TCP port
#	... - additional openssl options
#
#>
#/ Synopsis
#/    Prints the certificate notBefore date from a TLS server.
######################################################################
p6_openssl_not_before() {
    local host="$1" # FQDN of the website
    local port="$2" # TCP port
    shift 2         # additional openssl options

    p6_openssl_s_client_connect "$host" "$port" "$@" | openssl x509 -noout -startdate
}

######################################################################
#<
#
# Function: p6_openssl_serial(host, port, ...)
#
#  Args:
#	host - FQDN of the website
#	port - TCP port
#	... - additional openssl options
#
#>
#/ Synopsis
#/    Prints the certificate serial number from a TLS server.
######################################################################
p6_openssl_serial() {
    local host="$1" # FQDN of the website
    local port="$2" # TCP port
    shift 2         # additional openssl options

    p6_openssl_s_client_connect "$host" "$port" "$@" | openssl x509 -noout -serial
}

######################################################################
#<
#
# Function: p6_openssl_subject(host, port, ...)
#
#  Args:
#	host - FQDN of the website
#	port - TCP port
#	... - additional openssl options
#
#>
#/ Synopsis
#/    Prints the certificate subject from a TLS server.
######################################################################
p6_openssl_subject() {
    local host="$1" # FQDN of the website
    local port="$2" # TCP port
    shift 2         # additional openssl options

    p6_openssl_s_client_connect "$host" "$port" "$@" | openssl x509 -noout -subject
}

######################################################################
#<
#
# Function: p6_openssl_purpose(host, port, ...)
#
#  Args:
#	host - FQDN of the website
#	port - TCP port
#	... - additional openssl options
#
#>
#/ Synopsis
#/    Lists certificate purposes that are marked Yes.
######################################################################
p6_openssl_purpose() {
    local host="$1" # FQDN of the website
    local port="$2" # TCP port
    shift 2         # additional openssl options

    p6_openssl_s_client_connect "$host" "$port" "$@" | openssl x509 -noout -purpose | p6_filter_row_select "Yes"
}

######################################################################
#<
#
# Function: p6_openssl_not_purpose(host, port, ...)
#
#  Args:
#	host - FQDN of the website
#	port - TCP port
#	... - additional openssl options
#
#>
#/ Synopsis
#/    Lists certificate purposes that are marked No.
######################################################################
p6_openssl_not_purpose() {
    local host="$1" # FQDN of the website
    local port="$2" # TCP port
    shift 2         # additional openssl options

    p6_openssl_s_client_connect "$host" "$port" "$@" | openssl x509 -noout -purpose | p6_filter_row_select "No"
}

######################################################################
#<
#
# Function: p6_openssl_alias(host, port, ...)
#
#  Args:
#	host - FQDN of the website
#	port - TCP port
#	... - additional openssl options
#
#>
#/ Synopsis
#/    Prints the certificate alias from a TLS server.
######################################################################
p6_openssl_alias() {
    local host="$1" # FQDN of the website
    local port="$2" # TCP port
    shift 2         # additional openssl options

    p6_openssl_s_client_connect "$host" "$port" "$@" | openssl x509 -noout -alias
}

######################################################################
#<
#
# Function: p6_openssl_alt_name(host, port, ...)
#
#  Args:
#	host - FQDN of the website
#	port - TCP port
#	... - additional openssl options
#
#>
#/ Synopsis
#/    Prints the certificate Subject Alternative Names.
######################################################################
p6_openssl_alt_name() {
    local host="$1" # FQDN of the website
    local port="$2" # TCP port
    shift 2         # additional openssl options

    p6_openssl_s_client_connect "$host" "$port" "$@" | openssl x509 -noout -text | p6_filter_row_select_and_after "Alternative" 1 | p6_filter_row_last 1 | p6_filter_strip_spaces
}
