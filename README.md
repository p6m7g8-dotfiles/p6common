# P6's POSIX.2: p6common

## Table of Contents

- [Badges](#badges)
- [Summary](#summary)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Usage](#usage)
  - [Hooks](#hooks)
  - [Functions](#functions)
- [Hierarchy](#hierarchy)
- [Author](#author)

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

TODO: Add a short summary of this module.

## Contributing

- [How to Contribute](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Hooks

- `init` -> `p6df::modules::p6common::init(_module, dir)`

### Functions

#### cicd

##### p6common/lib/cicd/build.sh

- `p6_cicd_build_run([dockerfile=Dockerfile])`
  - Synopsis: Builds the current directory with Docker using the given Dockerfile.
  - Args:
    - OPTIONAL dockerfile - Dockerfile path [Dockerfile]

##### p6common/lib/cicd/doc.sh

- `p6_cicd_doc_gen()`
  - Synopsis: Regenerates module inline docs and README for the current module.

##### p6common/lib/cicd/release.sh

- `p6_cicd_release_make()`
  - Synopsis: Creates a standard-version release and pushes tags to origin.

#### date

##### p6common/lib/date/convert.sh

- `float hours = p6_date_convert_seconds_to_hours(seconds, [scale=3])`
  - Synopsis: Converts seconds to hours with the requested decimal scale.
  - Args:
    - seconds - The seconds to convert
    - OPTIONAL scale - Default scale is 3 if not provided [3]
- `str str = p6_date_convert_ms_epoch_to_local(ms_epoch)`
  - Synopsis: Converts milliseconds since epoch to a local ISO8601 string.
  - Args:
    - ms_epoch - milliseconds since epoch

##### p6common/lib/date/fmt.sh

- `p6_date_fmt_relative_to_absolute(relative)`
  - Synopsis: Converts a relative duration (e.g. "3 days") to an absolute date.
  - Args:
    - relative - relative duration string

##### p6common/lib/date/math.sh

- `float delta_hours = p6_date_math_delta_in_hours(d1, d2, fmt)`
  - Synopsis: Returns the delta between d1 and d2 in hours.
  - Args:
    - d1 - first date
    - d2 - second date
    - fmt - input format
- `int delta = p6_date_math_delta_in_seconds(d1, d2, in_fmt)`
  - Synopsis: Returns the delta between d1 and d2 in seconds.
  - Args:
    - d1 - first date
    - d2 - second date
    - in_fmt - input format
- `p6_date_math_move(date, offset, fmt_from, fmt_to)`
  - Synopsis: Applies a date offset and converts from fmt_from to fmt_to.
  - Args:
    - date - input date string
    - offset - date offset expression
    - fmt_from - input format
    - fmt_to - output format

##### p6common/lib/date/point.sh

- `int day = p6_date_point_last_day_of_ym(year, month)`
  - Synopsis: Computes the last day number of a given year and month.
  - Args:
    - year - year (YYYY)
    - month - month (1-12)
- `int end_month = p6_date_point_last_month_of_quarter(start_month)`
  - Synopsis: Returns the last month number for a quarter given its start month.
  - Args:
    - start_month - quarter start month
- `int first_month = p6_date_point_first_month_of_quarter(quarter)`
  - Synopsis: Returns the first month number for a given quarter.
  - Args:
    - quarter - quarter (1-4)
- `p6_date_point_now_epoch_seconds()`
  - Synopsis: Returns the current time as epoch seconds.
- `p6_date_point_now_ymd()`
  - Synopsis: Returns the current date as YYYYMMDD.
- `p6_date_point_today_ymd()`
  - Synopsis: Returns today as YYYY-MM-DD.
- `p6_date_point_tomorrow_ymd()`
  - Synopsis: Returns tomorrow as YYYYMMDD.
- `p6_date_point_yesterday_ymd()`
  - Synopsis: Returns yesterday as YYYYMMDD.

##### p6common/lib/date/range.sh

- `stream  = p6_date_range_fill(start_date, end_date, file, fmt, [sep=])`
  - Synopsis: Fills missing dates between start and end with zero values from a file.
  - Args:
    - start_date - first date (inclusive)
    - end_date - last date (inclusive)
    - file - input file of date/value rows
    - fmt - date format (unused)
    - OPTIONAL sep - column separator []

#### filter

##### p6common/lib/filter/aggregate.sh

- `filter  = p6_filter_aggregate_count()`
  - Synopsis: Count identical lines (expects sorted input).
- `filter  = p6_filter_aggregate_map_reduce()`
  - Synopsis: Sort input then count identical lines.
- `filter  = p6_filter_aggregate_table_by_group_with_count([sep=\t])`
  - Synopsis: Aggregate group rows into counts and per-column averages. Input: group c1 c2 c3... group c1 c2 c3...
  - Args:
    - OPTIONAL sep - field separator [\t]
- `filter  = p6_filter_aggregate_table_with_count([sep=\t])`
  - Synopsis: Aggregate a table into total count and per-column averages.
  - Args:
    - OPTIONAL sep - field separator [\t]

##### p6common/lib/filter/column.sh

- `filter  = p6_filter_column_pair_to_kv(key_column, value_column, [sep= ], [kv_sep==])`
  - Synopsis: Emit key/value pairs from two columns.
  - Args:
    - key_column - key column index
    - value_column - value column index
    - OPTIONAL sep - field separator [ ]
    - OPTIONAL kv_sep - key/value separator [=]
- `filter  = p6_filter_column_pluck(columns, [split= ], [selector=])`
  - Synopsis: Extract columns from delimited input.
  - Args:
    - columns - column spec (list, range, or index)
    - OPTIONAL split - field separator [ ]
    - OPTIONAL selector - optional line selector []
- `filter  = p6_filter_column_swap([sep=\t])`
  - Synopsis: Swap the first two columns.
  - Args:
    - OPTIONAL sep - field separator [\t]
- `filter  = p6_filter_columns_count([sep=\t])`
  - Synopsis: Print the number of columns in the first row.
  - Args:
    - OPTIONAL sep - field separator [\t]

##### p6common/lib/filter/date.sh

- `filter  = p6_filter_translate_date_to_iso8601_utc(column, input_fmt, ofs, fs)`
  - Synopsis: Replace a date column with UTC ISO8601 timestamps.
  - Args:
    - column - column index
    - input_fmt - input date format
    - ofs - output field separator
    - fs - input field separator
- `filter  = p6_filter_translate_ms_epoch_to_iso8601_local()`
  - Synopsis: Convert millisecond epoch values to local ISO8601 timestamps.

##### p6common/lib/filter/escape.sh

- `filter  = p6_filter_sql_escape_single_quote()`
  - Synopsis: Escape single quotes for SQL string literals.

##### p6common/lib/filter/extract.sh

- `filter  = p6_filter_extract_after(pattern)`
  - Synopsis: Strip everything through the pattern, leaving content after it.
  - Args:
    - pattern - delimiter pattern
- `filter  = p6_filter_extract_before(pattern)`
  - Synopsis: Strip everything after the pattern, leaving content before it.
  - Args:
    - pattern - delimiter pattern
- `filter  = p6_filter_extract_between(start, end)`
  - Synopsis: Extract content between start and end patterns.
  - Args:
    - start - start pattern
    - end - end pattern

##### p6common/lib/filter/kv.sh

- `filter  = p6_filter_kv_value(key, [sep==], [trim=1])`
  - Synopsis: Extract the value for a key from key/value lines.
  - Args:
    - key - key to match
    - OPTIONAL sep - key/value separator [=]
    - OPTIONAL trim - trim spaces when 1 [1]

##### p6common/lib/filter/row.sh

- `filter  = p6_filter_row_exclude(selector)`
  - Synopsis: Exclude rows matching a pattern.
  - Args:
    - selector - pattern
- `filter  = p6_filter_row_exclude_icase(selector)`
  - Synopsis: Exclude rows matching a pattern, case-insensitive.
  - Args:
    - selector - pattern
- `filter  = p6_filter_row_exclude_regex(selector)`
  - Synopsis: Exclude rows matching an extended regex.
  - Args:
    - selector - extended regex pattern
- `filter  = p6_filter_row_first(n)`
  - Synopsis: Keep only the first N rows.
  - Args:
    - n - number of rows
- `filter  = p6_filter_row_from_end(n)`
  - Synopsis: Emit the Nth row from the end.
  - Args:
    - n - index from end
- `filter  = p6_filter_row_last(n)`
  - Synopsis: Keep only the last N rows.
  - Args:
    - n - number of rows
- `filter  = p6_filter_row_n(n)`
  - Synopsis: Emit the Nth row from the start.
  - Args:
    - n - row number
- `filter  = p6_filter_row_select(...)`
  - Synopsis: Select rows matching the given grep arguments.
  - Args:
    - ... - grep options and pattern
- `filter  = p6_filter_row_select_and_after(selector, count)`
  - Synopsis: Select matching rows and the following N rows.
  - Args:
    - selector - pattern
    - count - number of following rows
- `filter  = p6_filter_row_select_icase(selector)`
  - Synopsis: Select rows matching a pattern, case-insensitive.
  - Args:
    - selector - pattern
- `filter  = p6_filter_row_select_regex(selector)`
  - Synopsis: Select rows matching an extended regex.
  - Args:
    - selector - extended regex pattern
- `filter  = p6_filter_rows_count()`
  - Synopsis: Count the number of rows.

##### p6common/lib/filter/sort.sh

- `filter  = p6_filter_sort(...)`
  - Synopsis: Sort stdin using `sort` with any provided options.
  - Args:
    - ... - sort options
- `filter  = p6_filter_sort_by_column(column, [sep=])`
  - Synopsis: Sort stdin by a column number with an optional separator.
  - Args:
    - column - column number (1-based)
    - OPTIONAL sep - field separator []
- `filter  = p6_filter_sort_by_key(key, [sep=])`
  - Synopsis: Sort stdin by a key field with an optional field separator.
  - Args:
    - key - sort key spec
    - OPTIONAL sep - field separator []
- `filter  = p6_filter_sort_numeric_by_column(column, [sep=])`
  - Synopsis: Sort stdin numerically by a column number.
  - Args:
    - column - column number (1-based)
    - OPTIONAL sep - field separator []
- `filter  = p6_filter_sort_numeric_reverse(...)`
  - Synopsis: Sort stdin numerically in reverse order.
  - Args:
    - ... - sort options
- `filter  = p6_filter_sort_reverse(...)`
  - Synopsis: Sort stdin in reverse order.
  - Args:
    - ... - sort options
- `filter  = p6_filter_sort_reverse_by_column(column, [sep=])`
  - Synopsis: Sort stdin by a column number in reverse order.
  - Args:
    - column - column number (1-based)
    - OPTIONAL sep - field separator []
- `filter  = p6_filter_sort_reverse_by_key(key, [sep=])`
  - Synopsis: Sort stdin by a key field in reverse order.
  - Args:
    - key - sort key spec
    - OPTIONAL sep - field separator []
- `filter  = p6_filter_sort_unique(...)`
  - Synopsis: Sort stdin and remove duplicate lines.
  - Args:
    - ... - sort options

##### p6common/lib/filter/string.sh

- `filter  = p6_filter_lowercase()`
  - Synopsis: Lowercase each input line.
- `filter  = p6_filter_string_first_character()`
  - Synopsis: Emit the first character of each input line.
- `filter  = p6_filter_uppercase()`
  - Synopsis: Uppercase each input line.

##### p6common/lib/filter/strip.sh

- `filter  = p6_filter_dos2unix()`
  - Synopsis: Convert CRLF line endings to LF.
- `filter  = p6_filter_strip_alum()`
  - Synopsis: Remove alphanumeric characters from each line.
- `filter  = p6_filter_strip_alum_and_underscore()`
  - Synopsis: Remove alphanumerics and underscores from each line.
- `filter  = p6_filter_strip_chars(chars)`
  - Synopsis: Strip the specified characters from each line.
  - Args:
    - chars - characters to remove
- `filter  = p6_filter_strip_double_quote()`
  - Synopsis: Strip double quotes from each line.
- `filter  = p6_filter_strip_leading_and_trailing_spaces()`
  - Synopsis: Strip leading and trailing spaces from each line.
- `filter  = p6_filter_strip_leading_spaces()`
  - Synopsis: Strip leading spaces from each line.
- `filter  = p6_filter_strip_quotes()`
  - Synopsis: Strip both single and double quotes from each line.
- `filter  = p6_filter_strip_single_quote()`
  - Synopsis: Strip single quotes from each line.
- `filter  = p6_filter_strip_spaces()`
  - Synopsis: Remove all spaces from each line.
- `filter  = p6_filter_strip_trailing_slash()`
  - Synopsis: Strip a trailing slash from each line.
- `filter  = p6_filter_strip_trailing_spaces()`
  - Synopsis: Strip trailing spaces from each line.

##### p6common/lib/filter/translate.sh

- `filter  = p6_filter_convert_multispace_delimited_columns_to_pipes()`
  - Synopsis: Convert multi-space-delimited columns to pipes.
- `filter  = p6_filter_insert_null_at_position(position)`
  - Synopsis: Ensure a NULL field exists at the given position.
  - Args:
    - position - 1-based field position
- `filter  = p6_filter_replace(from, to, [flags=g])`
  - Synopsis: Replace pattern matches with a replacement string on each line.
  - Args:
    - from - pattern to replace
    - to - replacement string
    - OPTIONAL flags - sed flags [g]
- `filter  = p6_filter_strip_leading_go()`
  - Synopsis: Strip a leading 'go' prefix when present.
- `filter  = p6_filter_strip_leading_v()`
  - Synopsis: Strip a leading 'v' prefix when present.
- `filter  = p6_filter_strip_scala3_prefix()`
  - Synopsis: Strip a leading 'scala3-' prefix when present.
- `filter  = p6_filter_translate_blank_to_null()`
  - Synopsis: Replace empty pipe-delimited fields with NULL.
- `filter  = p6_filter_translate_first_field_slash_to_pipe()`
  - Synopsis: Replace the first field's slash with a pipe.
- `filter  = p6_filter_translate_glob_to_underscore(glob)`
  - Synopsis: Replace a glob pattern with underscores on each line.
  - Args:
    - glob - glob pattern to replace
- `filter  = p6_filter_translate_hex_pairs_to_csv()`
  - Synopsis: Insert commas after each pair of hex characters.
- `filter  = p6_filter_translate_parens_to_slash()`
  - Synopsis: Replace parentheses with slashes.
- `filter  = p6_filter_translate_quoted_null_to_null()`
  - Synopsis: Replace quoted 'NULL' tokens with bare NULL.
- `filter  = p6_filter_translate_resource_records_label_to_tab()`
  - Synopsis: Replace RESOURCERECORDS with a tab delimiter.
- `filter  = p6_filter_translate_space_to_newline()`
  - Synopsis: Translate spaces into newlines.
- `filter  = p6_filter_translate_space_to_tab()`
  - Synopsis: Replace spaces with tabs.
- `filter  = p6_filter_translate_space_to_underscore()`
  - Synopsis: Replace spaces with underscores.
- `filter  = p6_filter_translate_start_to_arg(arg)`
  - Synopsis: Prefix each line with the provided string.
  - Args:
    - arg - prefix string
- `filter  = p6_filter_translate_tab_to_pipe()`
  - Synopsis: Replace tabs with pipe separators.
- `filter  = p6_filter_translate_trailing_slash_bang_to_bang()`
  - Synopsis: Replace '/!' sequences with '!'.
- `filter  = p6_filter_translate_words_to_sql_list([sep=|])`
  - Synopsis: Convert delimited words into a SQL list tuple.
  - Args:
    - OPTIONAL sep - field separator [|]

#### math

##### p6common/lib/math/arithmetic.sh

- `int result = p6_math_dec(a, [b=1])`
  - Synopsis: Subtracts b from a (default 1) and returns the integer result.
  - Args:
    - a - base value
    - OPTIONAL b - decrement [1]
- `int result = p6_math_inc(a, [b=1])`
  - Synopsis: Adds b to a (default 1) and returns the integer result.
  - Args:
    - a - base value
    - OPTIONAL b - increment [1]
- `int result = p6_math_multiply(a, b)`
  - Synopsis: Multiplies a by b and returns the integer result.
  - Args:
    - a - left operand
    - b - right operand
- `int rv = p6_math_sub(a, b)`
  - Synopsis: Subtracts b from a and returns the integer result.
  - Args:
    - a - minuend
    - b - subtrahend
- `p6_math_gt(a, b)`
  - Synopsis: Returns true when a is greater than b.
  - Args:
    - a - left operand
    - b - right operand
- `p6_math_gte(a, b)`
  - Synopsis: Returns true when a is greater than or equal to b.
  - Args:
    - a - left operand
    - b - right operand
- `p6_math_lt(a, b)`
  - Synopsis: Returns true when a is less than b.
  - Args:
    - a - left operand
    - b - right operand
- `p6_math_lte(a, b)`
  - Synopsis: Returns true when a is less than or equal to b.
  - Args:
    - a - left operand
    - b - right operand

##### p6common/lib/math/range.sh

- `words elements = p6_math_range_generate(begin, end)`
  - Synopsis: Generates an inclusive numeric range from begin to end.
  - Args:
    - begin - range start
    - end - range end

#### network

##### p6common/lib/network/download.sh

- `path dest = p6_network_file_download(url, dest, ...)`
  - Synopsis: Downloads a URL to a destination file.
  - Args:
    - url - source URL
    - dest - destination file path
    - ... - unused extra args

##### p6common/lib/network/network.sh

- `ipv4 ip = p6_network_ip_public()`
  - Synopsis: Fetches the public IPv4 address via ifconfig.me.

##### p6common/lib/network/ssh.sh

- `p6_ssh_key_add(key_file_priv)`
  - Synopsis: Adds a private key to the ssh-agent.
  - Args:
    - key_file_priv - private key file
- `p6_ssh_key_check(priv, test_pub)`
  - Synopsis: Compares a private key to a public key for a match.
  - Args:
    - priv - private key file
    - test_pub - public key file to compare
- `p6_ssh_key_delete(key_file_priv)`
  - Synopsis: Removes all keys from ssh-agent (with OS-specific flags).
  - Args:
    - key_file_priv - private key file
- `p6_ssh_key_fingerprint(key_file_pub)`
  - Synopsis: Prints the fingerprint for a public key.
  - Args:
    - key_file_pub - public key file
- `p6_ssh_key_make(key_file_priv)`
  - Synopsis: Creates a new ed25519 SSH key pair.
  - Args:
    - key_file_priv - private key file
- `p6_ssh_key_pub_from_priv(key_file_priv, [key_file_pub=${key_file_priv])`
  - Synopsis: Derives a public key from a private key file.
  - Args:
    - key_file_priv - private key file
    - OPTIONAL key_file_pub - public key file [${key_file_priv]
- `p6_ssh_key_remove(key_file_priv, [key_file_pub=${key_file_priv])`
  - Synopsis: Removes a private key and its associated public key.
  - Args:
    - key_file_priv - private key file
    - OPTIONAL key_file_pub - public key file [${key_file_priv]
- `p6_ssh_keys_chmod(key_file_priv)`
  - Synopsis: Sets secure permissions on the private key and its directory.
  - Args:
    - key_file_priv - private key file

#### openssl

##### p6common/lib/openssl/ciphers.sh

- `str str = p6_openssl_ciphers()`
  - Synopsis: Shows the supported Ciphers

##### p6common/lib/openssl/req.sh

- `p6_openssl_req_csr_create(key_file, csr_file, subject)`
  - Synopsis: Generates a new RSA key and CSR with the provided subject.
  - Args:
    - key_file - name of Key File (created)
    - csr_file - name of Certificate Signing Request file (created)
    - subject - I.E:  "/C=US/ST=Maryland/L=Bowie/O=P6M7G8/OU=Technology/CN=p6m7g8.net"

##### p6common/lib/openssl/s_client.sh

- `p6_openssl_alias(host, port, ...)`
  - Synopsis: Prints the certificate alias from a TLS server.
  - Args:
    - host - FQDN of the website
    - port - TCP port
    - ... - additional openssl options
- `p6_openssl_alt_name(host, port, ...)`
  - Synopsis: Prints the certificate Subject Alternative Names.
  - Args:
    - host - FQDN of the website
    - port - TCP port
    - ... - additional openssl options
- `p6_openssl_not_after(host, port, ...)`
  - Synopsis: Prints the certificate notAfter date from a TLS server.
  - Args:
    - host - FQDN of the website
    - port - TCP port
    - ... - additional openssl options
- `p6_openssl_not_before(host, port, ...)`
  - Synopsis: Prints the certificate notBefore date from a TLS server.
  - Args:
    - host - FQDN of the website
    - port - TCP port
    - ... - additional openssl options
- `p6_openssl_not_purpose(host, port, ...)`
  - Synopsis: Lists certificate purposes that are marked No.
  - Args:
    - host - FQDN of the website
    - port - TCP port
    - ... - additional openssl options
- `p6_openssl_purpose(host, port, ...)`
  - Synopsis: Lists certificate purposes that are marked Yes.
  - Args:
    - host - FQDN of the website
    - port - TCP port
    - ... - additional openssl options
- `p6_openssl_s_client_connect(host, [port=443], ...)`
  - Synopsis: Connects to $host on $port and returns the SSL Cert This already redirected to STDOUT Additional openssl options can be passed SSL is not allowed, only TLSv1+
  - Args:
    - host - FQDN of the website
    - OPTIONAL port - TCP port [443]
    - ... - additional openssl options
- `p6_openssl_serial(host, port, ...)`
  - Synopsis: Prints the certificate serial number from a TLS server.
  - Args:
    - host - FQDN of the website
    - port - TCP port
    - ... - additional openssl options
- `p6_openssl_subject(host, port, ...)`
  - Synopsis: Prints the certificate subject from a TLS server.
  - Args:
    - host - FQDN of the website
    - port - TCP port
    - ... - additional openssl options

##### p6common/lib/openssl/s_server.sh

- `p6_openssl_s_server_run(key, crt, ...)`
  - Synopsis: Default port is 4433 to listen on Responds to a 'GET /' with a status page
  - Args:
    - key - path to the key file
    - crt - path to the certificate file
    - ... - additional openssl options

##### p6common/lib/openssl/util.sh

- `p6_openssl_certificate_create(key_file, csr_file, subject, [cert_exp=365])`
  - Synopsis: Geenrates key_file, csr_file, and outputs certificate to stdout
  - Args:
    - key_file - name of Key File (created)
    - csr_file - name of Certificate Signing Request file (created)
    - subject - I.E:  "/C=US/ST=Maryland/L=Bowie/O=P6M7G8/OU=Technology/CN=p6m7g8.net"
    - OPTIONAL cert_exp - Ceritificate Expiration in days [365]

##### p6common/lib/openssl/version.sh

- `str str = p6_openssl_version()`
  - Synopsis: Returns the output of `openssl version -a`.

##### p6common/lib/openssl/x509.sh

- `p6_openssl_req_cert_self_signed_create(key_file, csr_file, [cert_exp=365])`
  - Synopsis: Generates a self-signed certificate from a CSR and key.
  - Args:
    - key_file - private key file
    - csr_file - CSR file
    - OPTIONAL cert_exp - certificate expiration in days [365]

#### p6common

##### p6common/init.zsh

- `p6df::modules::p6common::gha::ModuleDeps(module)`
  - Args:
    - module - 
- `p6df::modules::p6common::init(_module, dir)`
  - Args:
    - _module - 
    - dir - 

#### p6common/conf/debug

##### p6common/conf/debug/log-debug.sh

- `p6_log(msg)`
  - Args:
    - msg - 
- `p6_log_disable()`
- `p6_log_enable()`

##### p6common/conf/debug/time-debug.sh

- `p6_time(t0, t1, msg)`
  - Args:
    - t0 - 
    - t1 - 
    - msg - 

#### p6common/conf/prod

##### p6common/conf/prod/log-prod.sh

- `p6_log(msg)`
  - Args:
    - msg - 
- `p6_log_disable()`
- `p6_log_enable()`

##### p6common/conf/prod/time-prod.sh

- `p6_time(t0, t1, msg)`
  - Args:
    - t0 - 
    - t1 - 
    - msg - 

#### p6common/lib

##### p6common/lib/_bootstrap.sh

- `p6_bootstrap([dir=$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common], [islocal=])`
  - Synopsis: Loads p6common library files from dir and adds its bin to PATH.
  - Args:
    - OPTIONAL dir - library root to load [$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6common]
    - OPTIONAL islocal - unused flag for local bootstrap []

#### stdio

##### p6common/lib/stdio/color.sh

- `float 0.0 = p6_color_opacity_factor()`
  - Synopsis: Return the default opacity factor.
- `p6_color_ize(color_fg, color_bg, msg)`
  - Synopsis: Print a message with foreground/background colors (no newline).
  - Args:
    - color_fg - foreground color name
    - color_bg - background color name
    - msg - message text
- `p6_color_say(color_fg, color_bg, msg)`
  - Synopsis: Print a message with foreground/background colors and newline.
  - Args:
    - color_fg - foreground color name
    - color_bg - background color name
    - msg - message text
- `size_t channel = p6_color_hext_to_rgb(h)`
  - Synopsis: Convert a hex byte to a numeric channel value.
  - Args:
    - h - hex byte
- `size_t code = p6_color_to_code(color)`
  - Synopsis: Convert a color name to a tput color code.
  - Args:
    - color - color name
- `str dr = p6_color_hex_to_d16b(hex, ord)`
  - Synopsis: Convert hex RGB to a 16-bit channel value.
  - Args:
    - hex - hex RGB string
    - ord - channel selector (r/g/b)
- `str rgb = p6_color_name_to_rgb(name)`
  - Synopsis: Convert a color name to a hex RGB string.
  - Args:
    - name - color name

##### p6common/lib/stdio/dir.sh

- `p6_dir_cd(dir)`
  - Synopsis: Change to a directory with logging.
  - Args:
    - dir - directory path
- `p6_dir_cp(src, dst)`
  - Synopsis: Copy a directory recursively.
  - Args:
    - src - source directory
    - dst - destination directory
- `p6_dir_exists(dir)`
  - Synopsis: Return success when a directory exists.
  - Args:
    - dir - directory path
- `p6_dir_load(dirs)`
  - Synopsis: Load files from each directory in the list.
  - Args:
    - dirs - directory list
- `p6_dir_mk(dir)`
  - Synopsis: Create a directory if it does not exist.
  - Args:
    - dir - directory path
- `p6_dir_mv(src, dst)`
  - Synopsis: Move or rename a directory.
  - Args:
    - src - source directory
    - dst - destination directory
- `p6_dir_replace_in(dir, from, to)`
  - Synopsis: Replace text in files under a directory tree.
  - Args:
    - dir - directory root (unused in current implementation)
    - from - pattern to replace
    - to - replacement text
- `p6_dir_rmrf(dir)`
  - Synopsis: Remove a directory tree with safety checks.
  - Args:
    - dir - directory path
- `words children = p6_dir_list(dir)`
  - Synopsis: List entries in a directory.
  - Args:
    - dir - directory path
- `words descendants = p6_dir_list_recursive(dir)`
  - Synopsis: List files recursively under a directory.
  - Args:
    - dir - directory path
- `words entries = p6_dirs_list(dirs)`
  - Synopsis: List entries across multiple directories.
  - Args:
    - dirs - directory list

##### p6common/lib/stdio/file.sh

- `bool rv = p6_file_executable(file)`
  - Synopsis: Return true when a file is executable.
  - Args:
    - file - file path
- `bool rv = p6_file_exists(file)`
  - Synopsis: Return true when a file is readable.
  - Args:
    - file - file path
- `int count = p6_file_lines(file)`
  - Synopsis: Count the number of lines in a file.
  - Args:
    - file - file path
- `p6_file_append(file, contents)`
  - Synopsis: Append contents to a file.
  - Args:
    - file - file path
    - contents - content to append
- `p6_file_contains(pattern, file)`
  - Synopsis: Select lines from a file matching a pattern.
  - Args:
    - pattern - grep pattern
    - file - file path
- `p6_file_copy(src, dst)`
  - Synopsis: Copy a file.
  - Args:
    - src - source path
    - dst - destination path
- `p6_file_create(file)`
  - Synopsis: Create an empty file.
  - Args:
    - file - file path
- `p6_file_display(file)`
  - Synopsis: Output the contents of a file if it exists.
  - Args:
    - file - file path
- `p6_file_line_delete_last(file)`
  - Synopsis: Delete the last line of a file in place.
  - Args:
    - file - file path
- `p6_file_load(file)`
  - Synopsis: Source a file, honoring P6_PREFIX when set.
  - Args:
    - file - file path
- `p6_file_ma_sync(from, to)`
  - Synopsis: Sync modification time from one file to another.
  - Args:
    - from - source file
    - to - target file
- `p6_file_marker_delete_to_end(file, marker)`
  - Synopsis: Delete from the marker line to the end of the file.
  - Args:
    - file - file path
    - marker - marker pattern
- `p6_file_move(src, dst)`
  - Synopsis: Move or rename a file.
  - Args:
    - src - source path
    - dst - destination path
- `p6_file_replace(file, sed_cmd, file, sed_cmd)`
  - Synopsis: Run a sed expression in-place on a file.
  - Args:
    - file - file path
    - sed_cmd - sed expression
    - file - file path
    - sed_cmd - sed expression
- `p6_file_replace(file, sed_cmd, file, sed_cmd)`
  - Synopsis: Run a sed expression in-place on a file.
  - Args:
    - file - file path
    - sed_cmd - sed expression
    - file - file path
    - sed_cmd - sed expression
- `p6_file_rmf(file)`
  - Synopsis: Remove a file if it exists.
  - Args:
    - file - file path
- `p6_file_symlink(to, from)`
  - Synopsis: Create a symbolic link.
  - Args:
    - to - link target
    - from - link path
- `p6_file_unlink(file)`
  - Synopsis: Unlink a file.
  - Args:
    - file - file path
- `p6_file_write(file, contents)`
  - Synopsis: Overwrite a file with the given contents.
  - Args:
    - file - file path
    - contents - content to write
- `path path/$cmd = p6_file_cascade(cmd, exts, ...)`
  - Synopsis: Search paths for a command, optionally with extensions.
  - Args:
    - cmd - command name
    - exts - extension list
    - ... - search paths
- `size_t modified_epoch_seconds = p6_file_mtime(file)`
  - Synopsis: Return the file's modification time in epoch seconds.
  - Args:
    - file - file path
- `str line = p6_file_line_first(file)`
  - Synopsis: Return the first line of a file.
  - Args:
    - file - file path
- `str lines = p6_file_lines_except_first(file)`
  - Synopsis: Return all lines except the first.
  - Args:
    - file - file path
- `str lines = p6_file_lines_first(file, n)`
  - Synopsis: Return the first N lines of a file.
  - Args:
    - file - file path
    - n - number of lines
- `str lines = p6_file_lines_last(file, n)`
  - Synopsis: Return the last N lines of a file.
  - Args:
    - file - file path
    - n - number of lines

##### p6common/lib/stdio/interactive.sh

- `p6_int_confirm_ask()`
  - Synopsis: Prompt for Y/n confirmation and exit on "n".
- `str PASSWORD = p6_int_password_read()`
  - Synopsis: Read a password from stdin without echo.

##### p6common/lib/stdio/io.sh

- `p6_die(code, ...)`
  - Synopsis: Print a message and exit with the given code.
  - Args:
    - code - exit code
    - ... - message text
- `p6_echo()`
  - Synopsis: Echo arguments to stdout.
- `p6_error(msg)`
  - Synopsis: Print an error message to stderr.
  - Args:
    - msg - message text
- `p6_h1(header)`
  - Synopsis: Print a level-1 header.
  - Args:
    - header - header text
- `p6_h2(header)`
  - Synopsis: Print a level-2 header.
  - Args:
    - header - header text
- `p6_h3(header)`
  - Synopsis: Print a level-3 header.
  - Args:
    - header - header text
- `p6_h4(header)`
  - Synopsis: Print a level-4 header.
  - Args:
    - header - header text
- `p6_h5(header)`
  - Synopsis: Print a level-5 header.
  - Args:
    - header - header text
- `p6_h6(header)`
  - Synopsis: Print a level-6 header.
  - Args:
    - header - header text
- `p6_msg(msg)`
  - Synopsis: Print a message with a trailing newline.
  - Args:
    - msg - message text
- `p6_msg_fail()`
  - Synopsis: Print a failure message with a cross prefix.
- `p6_msg_h3()`
  - Synopsis: Print a level-3 header message.
- `p6_msg_no_nl(msg)`
  - Synopsis: Print a message without a trailing newline.
  - Args:
    - msg - message text
- `p6_msg_success()`
  - Synopsis: Print a success message with a checkmark prefix.
- `p6_vertical(v)`
  - Synopsis: Print a colon-delimited string vertically, one per line.
  - Args:
    - v - colon-delimited string

##### p6common/lib/stdio/verbose.sh

- `p6_verbose(level, ...)`
  - Synopsis: Print messages when verbosity meets the required level.
  - Args:
    - level - minimum verbosity before output
    - ... - message text

#### stdlib

##### p6common/lib/stdlib/alias.sh

- `p6_alias(from, to)`
  - Synopsis: Define a shell alias from one name to another command.
  - Args:
    - from - alias name
    - to - alias expansion
- `p6_alias_cd_dirs(dir)`
  - Synopsis: Create cd aliases for each subdirectory of a dir.
  - Args:
    - dir - directory path

##### p6common/lib/stdlib/ctl.sh

- `p6_ctl_cmd_build(dockerfile)`
  - Synopsis: Build the module using a Dockerfile.
  - Args:
    - dockerfile - Dockerfile path
- `p6_ctl_cmd_docker_build()`
  - Synopsis: Prepare docker build environment dependencies.
- `p6_ctl_cmd_docker_test()`
  - Synopsis: Run the test suite in a docker environment.
- `p6_ctl_cmd_install([home=pgollucci/home])`
  - Synopsis: Install p6 dotfiles into a target home repo.
  - Args:
    - OPTIONAL home - GitHub repo for home config [pgollucci/home]
- `p6_ctl_cmd_test()`
  - Synopsis: Run the module test suite.
- `p6_ctl_run(...)`
  - Synopsis: Parse CLI arguments and dispatch a p6ctl subcommand.
  - Args:
    - ... - arguments for p6ctl
- `p6_ctl_usage([rc=0], [msg=])`
  - Synopsis: Print usage and exit with the specified code.
  - Args:
    - OPTIONAL rc - exit code [0]
    - OPTIONAL msg - optional message []

##### p6common/lib/stdlib/diag.sh

- `p6_diagnostics()`
  - Synopsis: Add this to a Jenkins Job to see stuff or kubectl exec -it --rm foo -- /bin/bash into and look around

##### p6common/lib/stdlib/dryrunning.sh

- `bool rv = p6_dryrunning()`
  - Synopsis: Return true when dry-run mode is enabled.

##### p6common/lib/stdlib/edit.sh

- `p6_edit_editor_run(editor, scratch_file)`
  - Synopsis: Run an editor command on a scratch file.
  - Args:
    - editor - editor command
    - scratch_file - file to edit
- `path scratch_file = p6_edit_scratch_file_create(msg)`
  - Synopsis: Create a scratch file prefilled with a message.
  - Args:
    - msg - initial contents

##### p6common/lib/stdlib/env.sh

- `p6_env_export(var, val)`
  - Synopsis: Export an environment variable with a value.
  - Args:
    - var - variable name
    - val - variable value
- `p6_env_export_un(var)`
  - Synopsis: Unset an exported environment variable.
  - Args:
    - var - variable name
- `p6_env_list(glob)`
  - Synopsis: List environment variables, optionally filtered by a pattern.
  - Args:
    - glob - grep pattern
- `p6_env_list_p6()`
  - Synopsis: List all P6-related environment variables.

##### p6common/lib/stdlib/lang.sh

- `str prefix = p6_lang_cmd_2_env(cmd)`
  - Synopsis: Map a language command to its prefix.
  - Args:
    - cmd - command name
- `str rcmd = p6_lang_env_2_cmd(prefix)`
  - Synopsis: Map a language prefix to its command name.
  - Args:
    - prefix - language prefix
- `str ver = p6_lang_system_version(prefix)`
  - Synopsis: Return the system version for a language prefix.
  - Args:
    - prefix - language prefix
- `str ver = p6_lang_version(prefix)`
  - Synopsis: Return the active version for a language prefix.
  - Args:
    - prefix - language prefix (py, rb, node, etc.)

##### p6common/lib/stdlib/misc.sh

- `p6_pgs()`
  - Synopsis: Find and replace a pattern across files under the current tree.
- `p6_xclean()`
  - Synopsis: Delete common editor and backup junk files under the tree.

##### p6common/lib/stdlib/os.sh

- `str name = p6_os_name()`
  - Synopsis: Return the OS kernel release string.

##### p6common/lib/stdlib/path.sh

- `p6_cdpath_current()`
  - Synopsis: Print the current CDPATH entries vertically.
- `p6_path_current()`
  - Synopsis: Print the current PATH entries vertically.
- `p6_path_default()`
  - Synopsis: Reset PATH to a standard set of directories.
- `true  = p6_path_if(dir, [where=append])`
  - Synopsis: Add a directory to PATH when it exists.
  - Args:
    - dir - directory path
    - OPTIONAL where - append or prepend [append]

##### p6common/lib/stdlib/retry.sh

- `p6_retry_delay_doubling()`
  - Synopsis: Sleep and double the retry delay.
- `p6_retry_delay_log()`
  - Synopsis: Sleep and compute the next delay using log strategy.
- `size_t i = p6_retry_delay(type, i)`
  - Synopsis: Sleep for a delay and compute the next delay value.
  - Args:
    - type - delay strategy
    - i - current delay

##### p6common/lib/stdlib/run.sh

- `p6_run_code(code)`
  - Synopsis: Log and execute a command string.
  - Args:
    - code - command string
- `p6_run_code_and_result(code)`
  - Synopsis: Eval a command and eval its output into the shell.
  - Args:
    - code - command string
- `p6_run_dir(dir, ...)`
  - Synopsis: Run a command within a directory and return to the original.
  - Args:
    - dir - working directory
    - ... - command to run
- `p6_run_if(thing, ...)`
  - Synopsis: Run a function or command if it exists.
  - Args:
    - thing - function or command name
    - ... - arguments
- `p6_run_parallel(i, parallel, things, cmd, ...)`
  - Synopsis: Run a command in parallel over a list of items.
  - Args:
    - i - starting index
    - parallel - max parallel jobs
    - things - item list
    - cmd - command to run
    - ... - command arguments
- `p6_run_read_cmd(cmd)`
  - Synopsis: Run a command string (read-style helper).
  - Args:
    - cmd - command string
- `p6_run_retry(stop, fail, func, ...)`
  - Synopsis: Retry a function until a stop condition is met.
  - Args:
    - stop - stop callback
    - fail - failure callback (unused)
    - func - function to call
    - ... - function arguments
- `p6_run_script(cmd_env, shell, set_flags, cmd, [exts=.sh], arg_list, ...)`
  - Synopsis: Resolve and run a script with a clean environment.
  - Args:
    - cmd_env - env var assignments
    - shell - shell to execute
    - set_flags - shell flags
    - cmd - script base name
    - OPTIONAL exts - allowed extensions [.sh]
    - arg_list - argument list string
    - ... - search paths
- `p6_run_serial(things, cmd, ...)`
  - Synopsis: Run a command serially over a list of items.
  - Args:
    - things - item list
    - cmd - command to run
    - ... - command arguments
- `p6_run_write_cmd(cmd)`
  - Synopsis: Run a command string (write-style helper).
  - Args:
    - cmd - command string
- `p6_run_yield(func, ...)`
  - Synopsis: Invoke a function with arguments and return its status.
  - Args:
    - func - function to call
    - ... - function arguments
- `true  = p6_run_if_not_in(script, skip_list)`
  - Synopsis: Return true when a script is found in the skip list.
  - Args:
    - script - script name
    - skip_list - whitespace-separated list

##### p6common/lib/stdlib/template.sh

- `str processed = p6_template_process(infile, ...)`
  - Synopsis: Apply key/value replacements to a template file.
  - Args:
    - infile - template file path
    - ... - k=v replacements

##### p6common/lib/stdlib/transients.sh

- `p6_transient_delete(dir, [handler_name=])`
  - Synopsis: Deletes a transient directory unless it is persisted or under cleanup.
  - Args:
    - dir - transient directory path
    - OPTIONAL handler_name - cleanup handler name []
- `p6_transient_is(dir)`
  - Synopsis: Returns true when dir exists and is managed as a transient.
  - Args:
    - dir - transient directory path
- `p6_transient_persist(dir)`
  - Synopsis: Marks a transient directory as persisted.
  - Args:
    - dir - transient directory path
- `p6_transient_persist_is(dir)`
  - Synopsis: Returns true when a transient directory is marked persisted.
  - Args:
    - dir - transient directory path
- `p6_transient_persist_un(dir)`
  - Synopsis: Removes the persistence marker from a transient directory.
  - Args:
    - dir - transient directory path
- `path file = p6_transient_create_file(file_name)`
  - Synopsis: Creates a transient directory and returns a file path inside it.
  - Args:
    - file_name - transient file base name
- `str  = p6_transient_create(dir_name, [len=4])`
  - Synopsis: Creates a transient directory under P6_DIR_TRANSIENTS and returns its path.
  - Args:
    - dir_name - transient dir name
    - OPTIONAL len - random suffix length [4]

##### p6common/lib/stdlib/unroll.sh

- `p6_unroll_function(function)`
  - Synopsis: Emits the shell source of a function, optionally filtered for unrolling.
  - Args:
    - function - function name
- `p6_unroll_functions()`
  - Synopsis: Writes unrolled function definitions into fpath/ for each p6 function.
- `str s/p6_return_str/echo/g = p6_unroll_filter()`
  - Synopsis: Rewrites p6 return helpers into plain shell equivalents for filters.

#### string

##### p6common/lib/string/json.sh

- `p6_json_eval(json, ...)`
  - Synopsis: Run jq against a JSON string.
  - Args:
    - json - JSON input
    - ... - jq filter and options
- `p6_json_from_file(file)`
  - Synopsis: Output JSON content from a file.
  - Args:
    - file - JSON file path

##### p6common/lib/string/string.sh

- `bool rc = p6_string_eq_0(str)`
  - Synopsis: Return true when the string equals 0.
  - Args:
    - str - string to test
- `bool rc = p6_string_ne_0(str)`
  - Synopsis: Return true when the string does not equal 0.
  - Args:
    - str - string to test
- `bool rc = p6_string_eq_1(str)`
  - Synopsis: Return true when the string equals 1.
  - Args:
    - str - string to test
- `bool rc = p6_string_eq_neg_1(str)`
  - Synopsis: Return true when the string equals -1.
  - Args:
    - str - string to test
- `bool rv = p6_string_blank(str)`
  - Synopsis: Return true when the string is empty.
  - Args:
    - str - string to test
- `bool rv = p6_string_blank_NOT(str)`
  - Synopsis: Return true when the string is not empty.
  - Args:
    - str - string to test
- `bool rv = p6_string_contains(str, needle)`
  - Synopsis: Return true when the string contains the needle.
  - Args:
    - str - haystack string
    - needle - substring to find
- `bool rv = p6_string_ends_with(str, suffix)`
  - Synopsis: Return true when the string ends with the given suffix.
  - Args:
    - str - input string
    - suffix - suffix to match
- `bool rv = p6_string_eq(str, val)`
  - Synopsis: Return true when two strings are equal.
  - Args:
    - str - left-hand string
    - val - right-hand string
- `bool rv = p6_string_eq_any(str, ...)`
  - Synopsis: Return true when the string matches any of the provided values.
  - Args:
    - str - string to test
    - ... - remaining values to compare
- `bool rv = p6_string_match_regex(str, re)`
  - Synopsis: Return true when the string matches the regex pattern.
  - Args:
    - str - input string
    - re - extended regex
- `bool rv = p6_string_ne(str, val)`
  - Synopsis: Return true when two strings are different.
  - Args:
    - str - left-hand string
    - val - right-hand string
- `bool rv = p6_string_starts_with(str, prefix)`
  - Synopsis: Return true when the string starts with the given prefix.
  - Args:
    - str - input string
    - prefix - prefix to match
- `size_t len = p6_string_len(str)`
  - Synopsis: Return the length of the string in characters.
  - Args:
    - str - input string
- `str out = p6_string_default(str, default)`
  - Synopsis: Return the default when the string is blank.
  - Args:
    - str - input string
    - default - fallback value
- `str padded = p6_string_zero_pad(str, pad)`
  - Synopsis: Zero-pad a number to a fixed width.
  - Args:
    - str - numeric string
    - pad - width to pad to
- `str str_a = p6_string_append(str, add, [sep= ])`
  - Synopsis: Append a value to a string with a separator.
  - Args:
    - str - base string
    - add - string to append
    - OPTIONAL sep - separator between parts [ ]
- `str str_a = p6_string_prepend(str, add, [sep= ])`
  - Synopsis: Prepend a value to a string with a separator.
  - Args:
    - str - base string
    - add - string to prepend
    - OPTIONAL sep - separator between parts [ ]
- `str str_ic = p6_string_init_cap(str)`
  - Synopsis: Capitalize the first letter of each word.
  - Args:
    - str - input string
- `str str_lc = p6_string_lc(str)`
  - Synopsis: Lowercase a string.
  - Args:
    - str - input string
- `str str_r = p6_string_collapse_double_slash(str)`
  - Synopsis: Collapse repeated slashes to single slashes.
  - Args:
    - str - input string
- `str str_r = p6_string_nodeenv_to_nodenv(str)`
  - Synopsis: Rewrite nodeenv to nodenv within a string.
  - Args:
    - str - input string
- `str str_r = p6_string_replace(str, from, to, [flags=g])`
  - Synopsis: Replace pattern matches with a replacement string.
  - Args:
    - str - input string
    - from - sed pattern to replace
    - to - replacement string
    - OPTIONAL flags - sed flags (default: global) [g]
- `str str_r = p6_string_sanitize_dot_id(str)`
  - Synopsis: Normalize a dotted identifier by replacing :/.- with underscores.
  - Args:
    - str - input string
- `str str_r = p6_string_sanitize_identifier(str)`
  - Synopsis: Convert non-identifier characters to underscores.
  - Args:
    - str - input string
- `str str_r = p6_string_slash_to_underscore(str)`
  - Synopsis: Replace slashes with underscores.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_alum(str)`
  - Synopsis: Remove all alphanumeric characters from a string.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_alum_and_underscore(str)`
  - Synopsis: Remove alphanumerics and underscores from a string.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_brackets(str)`
  - Synopsis: Remove literal square brackets from a string.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_chars(str, chars)`
  - Synopsis: Remove all occurrences of the given character set.
  - Args:
    - str - input string
    - chars - character class to remove
- `str str_r = p6_string_strip_double_quote(str)`
  - Synopsis: Remove double quotes from a string.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_leading_and_trailing_spaces(str)`
  - Synopsis: Strip both leading and trailing spaces from a string.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_leading_spaces(str)`
  - Synopsis: Strip leading spaces from a string.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_non_branch_chars(str)`
  - Synopsis: Remove characters not allowed in branch identifiers.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_prefix(str, prefix)`
  - Synopsis: Remove a prefix when present.
  - Args:
    - str - input string
    - prefix - prefix to remove
- `str str_r = p6_string_strip_quotes(str)`
  - Synopsis: Remove both single and double quotes from a string.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_single_quote(str)`
  - Synopsis: Remove single quotes from a string.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_spaces(str)`
  - Synopsis: Remove all spaces from a string.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_suffix(str, suffix)`
  - Synopsis: Remove a suffix when present.
  - Args:
    - str - input string
    - suffix - suffix to remove
- `str str_r = p6_string_strip_trailing_slash(str)`
  - Synopsis: Strip a trailing slash from a path-like string.
  - Args:
    - str - input string
- `str str_r = p6_string_strip_trailing_spaces(str)`
  - Synopsis: Strip trailing spaces from a string.
  - Args:
    - str - input string
- `str str_uc = p6_string_uc(str)`
  - Synopsis: Uppercase a string.
  - Args:
    - str - input string

##### p6common/lib/string/tokens.sh

- `p6_token_encode_base64(string)`
  - Synopsis: Base64-encode the provided string.
  - Args:
    - string - input string
- `p6_token_sha256(string)`
  - Synopsis: Print the SHA-256 hash of the provided string.
  - Args:
    - string - input string
- `str hashed = p6_token_hash(string)`
  - Synopsis: Compute an MD5 hash of the provided string.
  - Args:
    - string - input string
- `str pass = p6_token_passwd(len)`
  - Synopsis: Generate a random password of the given length.
  - Args:
    - len - password length
- `str token = p6_token_random(len)`
  - Synopsis: Generate a random alphanumeric token of the given length.
  - Args:
    - len - token length

##### p6common/lib/string/uri.sh

- `path name = p6_uri_name(uri)`
  - Synopsis: Return the basename component of a URI or path.
  - Args:
    - uri - input URI/path
- `path name = p6_uri_path(uri)`
  - Synopsis: Return the directory component of a URI or path.
  - Args:
    - uri - input URI/path

##### p6common/lib/string/word.sh

- `true  = p6_word_in(word, ..., words)`
  - Synopsis: Return true when a word is found in the list.
  - Args:
    - word - word to find
    - ... - remaining words
    - words - word list
- `words result = p6_word_not(a, b)`
  - Synopsis: Return words that appear in A but not in B.
  - Args:
    - a - word list A
    - b - word list B
- `words words = p6_word_unique(...)`
  - Synopsis: Return unique words from the provided arguments.
  - Args:
    - ... - words to uniquify

##### p6common/lib/string/yml.sh

- `p6_yml_eval(yml, ...)`
  - Synopsis: Evaluates a yq query against a YAML string.
  - Args:
    - yml - YAML content
    - ... - yq options and query
- `p6_yml_from_file(file)`
  - Synopsis: Reads YAML from file and emits it via yq.
  - Args:
    - file - YAML file path

#### types

##### p6common/lib/types/return.sh

- `bool  = p6_return_bool(bool)`
  - Synopsis: Exactly 0 or 1 No blanks Suitable for use in conditionals
  - Args:
    - bool - boolean value (0 or 1)
- `false  = p6_return_false()`
  - Synopsis: Suitable for use in conditionals
- `filter  = p6_return_filter()`
  - Synopsis: Filters return this for syntaxtic sugar Maintains the filters $? rc code for pipe chain short circuits
- `float  = p6_return_float(float)`
  - Synopsis: Any floating point No blanks
  - Args:
    - float - floating-point number
- `int  = p6_return_int(int)`
  - Synopsis: Any Integer Positive or Negative
  - Args:
    - int - integer (positive or negative)
- `ipv4  = p6_return_ipv4(ip)`
  - Synopsis: Any IP v4 address
  - Args:
    - ip - IPv4 address string
- `p6_return_code_as_code(rc)`
  - Synopsis: Validates rc and returns it as the function exit code.
  - Args:
    - rc - return code (0..255)
- `p6_return_code_as_value(rc)`
  - Synopsis: Validates rc and prints it to stdout.
  - Args:
    - rc - return code (0..255)
- `p6_return_date(date)`
  - Synopsis: Only the listed dates are allowed Think twice before adding more
  - Args:
    - date - date string in accepted formats
- `p6_return_void()`
  - Synopsis: The literal absence of a return value Do not use this in conditionals Do not use this in blank string checks Use me when the function simply groups commands for re-use
- `path  = p6_return_path(path)`
  - Synopsis: Specialized string of well formed simple unix paths Only /, letters, numbers, -, _, @, +, ~, ., ',' NO SPACES, QUOTES etc...
  - Args:
    - path - unix-like path string
- `size_t  = p6_return_size_t(size_t)`
  - Synopsis: Any Positive Integer No blanks
  - Args:
    - size_t - non-negative integer
- `str  = p6_return_str(str)`
  - Synopsis: Any string BLANKS allowed
  - Args:
    - str - string value (blanks allowed)
- `stream  = p6_return_stream()`
  - Synopsis: Function emits arbitrary text
- `true  = p6_return(rv)`
  - Synopsis: Prints rv to stdout and returns success.
  - Args:
    - rv - value to echo
- `true  = p6_return_true()`
  - Synopsis: Suitable for use in conditionals
- `words  = p6_return_words(words)`
  - Synopsis: A word is a loop item. Words is a collection of words. Words should be split on $IFS "" or '' count as a blank word
  - Args:
    - words - words list (preserves splits)

## Hierarchy

```text
.
├── bin
│   └── p6ctl
├── conf
│   ├── debug
│   │   ├── debug-debug.sh
│   │   ├── log-debug.sh
│   │   ├── time-debug.sh
│   │   └── trace-debug.sh
│   └── prod
│       ├── debug-prod.sh
│       ├── log-prod.sh
│       ├── time-prod.sh
│       └── trace-debug.sh
├── Dockerfile
├── init.zsh
├── lib
│   ├── _bootstrap.sh
│   ├── cicd
│   │   ├── build.sh
│   │   ├── deploy.sh
│   │   ├── doc.sh
│   │   ├── release.sh
│   │   └── test.sh
│   ├── date
│   │   ├── convert.sh
│   │   ├── debug.sh
│   │   ├── fmt.sh
│   │   ├── math.sh
│   │   ├── point.sh
│   │   └── range.sh
│   ├── filter
│   │   ├── aggregate.sh
│   │   ├── column.sh
│   │   ├── date.sh
│   │   ├── debug.sh
│   │   ├── escape.sh
│   │   ├── extract.sh
│   │   ├── kv.sh
│   │   ├── row.sh
│   │   ├── sort.sh
│   │   ├── string.sh
│   │   ├── strip.sh
│   │   └── translate.sh
│   ├── math
│   │   ├── arithmetic.sh
│   │   └── range.sh
│   ├── network
│   │   ├── download.sh
│   │   ├── network.sh
│   │   └── ssh.sh
│   ├── openssl
│   │   ├── ciphers.sh
│   │   ├── debug.sh
│   │   ├── req.sh
│   │   ├── s_client.sh
│   │   ├── s_server.sh
│   │   ├── util.sh
│   │   ├── verify.sh
│   │   ├── version.sh
│   │   └── x509.sh
│   ├── prod -> ../conf/prod
│   ├── stdio
│   │   ├── color.sh
│   │   ├── dir.sh
│   │   ├── file.sh
│   │   ├── interactive.sh
│   │   ├── io.sh
│   │   └── verbose.sh
│   ├── stdlib
│   │   ├── alias.sh
│   │   ├── const.sh
│   │   ├── ctl.sh
│   │   ├── diag.sh
│   │   ├── dryrunning.sh
│   │   ├── edit.sh
│   │   ├── env.sh
│   │   ├── lang.sh
│   │   ├── misc.sh
│   │   ├── os.sh
│   │   ├── path.sh
│   │   ├── retry.sh
│   │   ├── run.sh
│   │   ├── template.sh
│   │   ├── transients.sh
│   │   └── unroll.sh
│   ├── string
│   │   ├── json.sh
│   │   ├── string.sh
│   │   ├── tokens.sh
│   │   ├── uri.sh
│   │   ├── word.sh
│   │   └── yml.sh
│   ├── test
│   │   ├── api.sh
│   │   ├── asserts.sh
│   │   ├── harness.sh
│   │   ├── run.sh
│   │   ├── state.sh
│   │   └── tap.sh
│   └── types
│       └── return.sh
├── README.md
└── t
    ├── alias.sh
    ├── cicd.sh
    ├── color.sh
    ├── const.sh
    ├── ctl.sh
    ├── date.sh
    ├── debug.sh
    ├── diag.sh
    ├── dir.sh
    ├── dryrunning.sh
    ├── edit.sh
    ├── env.sh
    ├── file.sh
    ├── filter.sh
    ├── inc.sh
    ├── interactive.sh
    ├── io.sh
    ├── json.sh
    ├── lang.sh
    ├── math.sh
    ├── misc.sh
    ├── openssl.sh
    ├── os.sh
    ├── path.sh
    ├── remote.sh
    ├── retry.sh
    ├── return.sh
    ├── run.sh
    ├── ssh.sh
    ├── string.sh
    ├── template.sh
    ├── tokens.sh
    ├── transients.sh
    ├── unroll.sh
    ├── uri.sh
    ├── verbose.sh
    ├── word.sh
    └── yml.sh

19 directories, 123 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
