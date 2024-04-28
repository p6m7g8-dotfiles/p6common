# P6's POSIX.2: p6common

## Table of Contents

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Mergify](https://img.shields.io/endpoint.svg?url=https://gh.mergify.io/badges//p6common/&style=flat)](https://mergify.io)
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](<https://gitpod.io/#https://github.com//p6common>)

## Summary

## Contributing

- [How to Contribute](<https://github.com//.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com//.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Aliases

### Functions

## cicd

### p6common/lib/cicd/build.sh

- p6_cicd_build_run()

### p6common/lib/cicd/doc.sh

- p6_cicd_doc_gen()

### p6common/lib/cicd/release.sh

- code  = p6_cicd_release_make()

## date

### p6common/lib/date/convert.sh

- float hours = p6_date_convert_seconds_to_hours()

### p6common/lib/date/fmt.sh

- p6_date_fmt_relative_to_absolute(relative)

### p6common/lib/date/math.sh

- float delta_hours = p6_date_math_delta_in_hours(d1, d2, fmt)
- int delta = p6_date_math_delta_in_seconds(d1, d2, in_fmt)
- p6_date_math_move()

### p6common/lib/date/point.sh

- p6_date_point_now_epoch_seconds()
- p6_date_point_now_ymd()
- p6_date_point_today_ymd()
- p6_date_point_tomorrow_ymd()
- p6_date_point_yesterday_ymd()

### p6common/lib/date/range.sh

- stream  = p6_date_range_fill()

## filter

### p6common/lib/filter/aggregate.sh

- filter  = p6_filter_aggregrate_map_reduce()
- filter  = p6_filter_aggregrate_table_by_group_with_count([sep=\t])
- filter  = p6_filter_aggregrate_table_with_count([sep=\t])

### p6common/lib/filter/column.sh

- filter  = p6_filter_column_pluck(columns, [split= ], [selector=])
- filter  = p6_filter_column_swap([sep=\t])
- filter  = p6_filter_columns_count([sep=\t])

### p6common/lib/filter/escape.sh

- filter  = p6_filter_sql_escape_single_quote()

### p6common/lib/filter/row.sh

- filter  = p6_filter_row_exclude(selector)
- filter  = p6_filter_row_first(n)
- filter  = p6_filter_row_from_end(n)
- filter  = p6_filter_row_last(n)
- filter  = p6_filter_row_n(n)
- filter  = p6_filter_row_select()
- filter  = p6_filter_row_select_and_after(selector, count)
- filter  = p6_filter_rows_count()

### p6common/lib/filter/sort.sh

- filter  = p6_filter_sort()
- filter  = p6_filter_sort_reverse()

### p6common/lib/filter/string.sh

- filter  = p6_filter_string_first_character()

### p6common/lib/filter/strip.sh

- filter  = p6_filter_alnum_and_underscore_strip()
- filter  = p6_filter_alnum_strip()
- filter  = p6_filter_double_quote_strip()
- filter  = p6_filter_leading_and_trailing_spaces_strip()
- filter  = p6_filter_leading_spaces_strip()
- filter  = p6_filter_quotes_strip()
- filter  = p6_filter_single_quote_strip()
- filter  = p6_filter_spaces_strip()
- filter  = p6_filter_trailing_slash_strip()
- filter  = p6_filter_trailing_spaces_strip()

### p6common/lib/filter/translate.sh

- filter  = p6_filter_translate_glob_to_underscore()
- filter  = p6_filter_translate_parens_to_slash()
- filter  = p6_filter_translate_space_to_tab()
- filter  = p6_filter_translate_space_to_underscore()
- filter  = p6_filter_translate_trailing_slash_bang_to_bang()
- filter  = p6_filter_translate_words_to_sql_list([sep=|])

## math

### p6common/lib/math/math.sh

- code rc = p6_math_gt(a, b)
- code rc = p6_math_gte(a, b)
- code rc = p6_math_lt()
- code rc = p6_math_lte(a, b)
- int result = p6_math_dec(a, [b=1])
- int result = p6_math_inc(a, [b=1])
- int result = p6_math_multiply(a, b)
- int rv = p6_math_sub(a, b)

## network

### p6common/lib/network/download.sh

- path dest = p6_network_file_download()

### p6common/lib/network/network.sh

- ipv4 ip = p6_network_ip_public()

### p6common/lib/network/remote.sh

- p6_remote_ssh_do(cmd)

### p6common/lib/network/ssh.sh

- code rc = p6_ssh_key_check(priv, test_pub)
- p6_ssh_key_add(key_file_priv)
- p6_ssh_key_delete(key_file_priv)
- p6_ssh_key_fingerprint()
- p6_ssh_key_make(key_file_priv)
- p6_ssh_key_pub_from_priv(key_file_priv, [key_file_pub=${key_file_priv])
- p6_ssh_key_remove(key_file_priv, [key_file_pub=${key_file_priv])
- p6_ssh_keys_chmod(key_file_priv)

## openssl

### p6common/lib/openssl/ciphers.sh

- str str = p6_openssl_ciphers()

### p6common/lib/openssl/req.sh

- p6_openssl_req_csr_create()

### p6common/lib/openssl/s_client.sh

- p6_openssl_alias(host, port, ...)
- p6_openssl_alt_name(host, port, ...)
- p6_openssl_not_after(host, port, ...)
- p6_openssl_not_before(host, port, ...)
- p6_openssl_not_purpose(host, port, ...)
- p6_openssl_purpose(host, port, ...)
- p6_openssl_s_client_connect()
- p6_openssl_serial(host, port, ...)
- p6_openssl_subject(host, port, ...)

### p6common/lib/openssl/s_server.sh

- p6_openssl_s_server_run()

### p6common/lib/openssl/util.sh

- p6_openssl_certificate_create()

### p6common/lib/openssl/version.sh

- str str = p6_openssl_version()

### p6common/lib/openssl/x509.sh

- p6_openssl_req_cert_self_signed_create()

## p6common

### p6common/init.zsh

- p6df::modules::p6common::init(_module, dir)

## p6common/conf/debug

### p6common/conf/debug/log-debug.sh

- p6_log(msg)
- p6_log_disable()
- p6_log_enable()

### p6common/conf/debug/time-debug.sh

- p6_time(t0, t1, msg)

## p6common/conf/prod

### p6common/conf/prod/log-prod.sh

- p6_log(msg)
- p6_log_disable()
- p6_log_enable()

### p6common/conf/prod/time-prod.sh

- p6_time(t0, t1, msg)

## p6common/lib

### p6common/lib/_bootstrap.sh

- p6_bootstrap()

## stdio

### p6common/lib/stdio/color.sh

- float 0.0 = p6_color_opacity_factor()
- p6_color_hex_to_d16b(hex, ord)
- p6_color_ize(color_fg, color_bg, msg)
- p6_color_say(color_fg, color_bg, msg)
- size_t channel = p6_color_hext_to_rgb(h)
- size_t code = p6_color_to_code(color)
- str rgb = p6_color_name_to_rgb(name)

### p6common/lib/stdio/dir.sh

- code rc = p6_dir_exists(dir)
- p6_dir_cd(dir)
- p6_dir_cp(src, dst)
- p6_dir_load(dirs)
- p6_dir_mk(dir)
- p6_dir_mv(src, dst)
- p6_dir_replace_in(dir, from, to)
- p6_dir_rmrf(dir)
- words children = p6_dir_list(dir)
- words descendants = p6_dir_list_recursive(dir)
- words entries = p6_dirs_list(dirs)

### p6common/lib/stdio/file.sh

- bool rv = p6_file_executable(file)
- bool rv = p6_file_exists(file)
- int count = p6_file_lines(file)
- p6_file_append(file, contents)
- p6_file_contains(pattern, file)
- p6_file_copy(src, dst)
- p6_file_create(file)
- p6_file_display(file)
- p6_file_line_delete_last(file)
- p6_file_load(file)
- p6_file_ma_sync(from, to)
- p6_file_marker_delete_to_end(file, marker)
- p6_file_move(src, dst)
- p6_file_replace(file, sed_cmd, file, sed_cmd)
- p6_file_replace(file, sed_cmd, file, sed_cmd)
- p6_file_rmf(file)
- p6_file_symlink(to, from)
- p6_file_unlink(file)
- p6_file_write(file, contents)
- path path/$cmd = p6_file_cascade(cmd, exts, ...)
- size_t modified_epoch_seconds = p6_file_mtime(file)
- str line = p6_file_line_first(file)
- str lines = p6_file_lines_except_first(file)
- str lines = p6_file_lines_first(file, n)
- str lines = p6_file_lines_last(file, n)

### p6common/lib/stdio/interactive.sh

- code 42 = p6_int_confirm_ask()
- str PASSWORD = p6_int_password_read()

### p6common/lib/stdio/io.sh

- p6_die(code)
- p6_echo()
- p6_error(msg)
- p6_h1(header)
- p6_h2(header)
- p6_h3(header)
- p6_h4(header)
- p6_h5(header)
- p6_msg(msg)
- p6_msg_fail()
- p6_msg_h3()
- p6_msg_no_nl(msg)
- p6_msg_success()
- p6_vertical(v)

### p6common/lib/stdio/verbose.sh

- p6_verbose(level)

## stdlib

### p6common/lib/stdlib/alias.sh

- p6_alias(from, to)
- p6_alias_cd_dirs(dir)

### p6common/lib/stdlib/ctl.sh

- p6_ctl_cmd_build(dockerfile)
- p6_ctl_cmd_docker_build()
- p6_ctl_cmd_docker_test()
- p6_ctl_cmd_install([home=pgollucci/home])
- p6_ctl_cmd_test()
- p6_ctl_run(...)
- p6_ctl_usage()

### p6common/lib/stdlib/diag.sh

- p6_diagnostics()

### p6common/lib/stdlib/dryrunning.sh

- bool rv = p6_dryrunning()

### p6common/lib/stdlib/edit.sh

- code ? = p6_edit_editor_run()
- path scratch_file = p6_edit_scratch_file_create(msg)

### p6common/lib/stdlib/env.sh

- p6_env_export(var, val)
- p6_env_export_un(var)
- p6_env_list(glob)
- p6_env_list_p6()

### p6common/lib/stdlib/lang.sh

- str prefix = p6_lang_cmd_2_env(cmd)
- str rcmd = p6_lang_env_2_cmd(prefix)
- str v = p6_lang_version(prefix)
- str ver = p6_lang_system_version(prefix)

### p6common/lib/stdlib/misc.sh

- p6_pgs()
- p6_xclean()

### p6common/lib/stdlib/os.sh

- str name = p6_os_name()

### p6common/lib/stdlib/path.sh

- p6_cdpath_current()
- p6_path_current()
- p6_path_default()
- true  = p6_path_if(dir)

### p6common/lib/stdlib/retry.sh

- p6_retry_delay_doubling()
- p6_retry_delay_log()
- size_t i = p6_retry_delay(type, i)

### p6common/lib/stdlib/run.sh

- code rc = p6_run_code(code)
- code rc = p6_run_read_cmd(cmd)
- code rc = p6_run_write_cmd(cmd)
- code rc = p6_run_yield(func, ...)
- code status = p6_run_retry(stop, fail, func, ...)
- p6_run_code_and_result(code)
- p6_run_dir(dir, ...)
- p6_run_if(thing, ...)
- p6_run_parallel(i, parallel, things, cmd, ...)
- p6_run_script(cmd_env, shell, set_flags, cmd, [exts=.sh], arg_list, ...)
- p6_run_serial(things, cmd, ...)
- true  = p6_run_if_not_in(script, skip_list)

### p6common/lib/stdlib/template.sh

- str processed = p6_template_process(infile, ...)

### p6common/lib/stdlib/transients.sh

- code rc = p6_transient_is(dir)
- code rc = p6_transient_persist_is(dir)
- p6_transient_delete(dir, [handler_name=])
- p6_transient_persist(dir)
- p6_transient_persist_un(dir)
- path file = p6_transient_create_file(file_name)
- str  = p6_transient_create(dir_name, [len=4])

### p6common/lib/stdlib/unroll.sh

- p6_unroll_function(function)
- p6_unroll_functions()

## string

### p6common/lib/string/json.sh

- p6_json_eval(json, ...)
- p6_json_from_file(file)

### p6common/lib/string/string.sh

- bool rc = p6_string_eq_1(str)
- bool rv = p6_string_blank(str)
- bool rv = p6_string_eq(str, val)
- size_t len = p6_string_len(str)
- str str_a = p6_string_append(str, add, [sep= ])
- str str_ic = p6_string_init_cap(str)
- str str_lc = p6_string_lc(str)
- str str_r = p6_string_replace(str, from, to)
- str str_uc = p6_string_uc(str)

### p6common/lib/string/tokens.sh

- p6_token_encode_base64(string)
- p6_token_sha256(string)
- str hashed = p6_token_hash(string)
- str pass = p6_token_passwd(len)
- str token = p6_token_random(len)

### p6common/lib/string/uri.sh

- path name = p6_uri_name(uri)
- path name = p6_uri_path(uri)

### p6common/lib/string/word.sh

- true  = p6_word_in(word, ..., words)
- words result = p6_word_not(a, b)
- words words = p6_word_unique(...)

## types

### p6common/lib/types/return.sh

- code  = p6_return_false()
- code  = p6_return_true()
- code bool = p6_return_bool(bool)
- code rc = p6_return_code_as_code(rc)
- code rc = p6_return_code_as_value(rc)
- code rc = p6_return_filter(rc)
- p6_return_date(date)
- p6_return_float(float)
- p6_return_int(int)
- p6_return_ipv4(ip)
- p6_return_path(path)
- p6_return_size_t(size_t)
- p6_return_str(str)
- p6_return_void()
- p6_return_words(words)
- true  = p6_return(rv)
- true  = p6_return_stream()

## Hierarchy

```text
.
├── Dockerfile
├── README.md
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
│   ├── debug -> ../conf/prod
│   ├── filter
│   │   ├── aggregate.sh
│   │   ├── column.sh
│   │   ├── debug.sh
│   │   ├── escape.sh
│   │   ├── row.sh
│   │   ├── sort.sh
│   │   ├── string.sh
│   │   ├── strip.sh
│   │   └── translate.sh
│   ├── math
│   │   └── math.sh
│   ├── network
│   │   ├── download.sh
│   │   ├── network.sh
│   │   ├── remote.sh
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
│   │   └── word.sh
│   ├── test
│   │   ├── _bootstrap.sh
│   │   ├── _colors.sh
│   │   ├── _util.sh
│   │   ├── api.sh
│   │   ├── asserts
│   │   │   └── aserts.sh
│   │   ├── backends
│   │   │   └── tap.sh
│   │   ├── bench.sh
│   │   └── harness.sh
│   └── types
│       └── return.sh
└── t
    ├── alias.sh
    ├── color.sh
    ├── const.sh
    ├── date.sh
    ├── debug.sh
    ├── dir.sh
    ├── file.sh
    ├── inc.sh
    ├── interactive.sh
    ├── io.sh
    ├── json.sh
    ├── lang.sh
    ├── math.sh
    ├── os.sh
    ├── path.sh
    ├── remote.sh
    ├── retry.sh
    ├── return.sh
    ├── run.sh
    ├── ssh.sh
    ├── string.sh
    └── tokens.sh

21 directories, 105 files
```

## Author

Philip M . Gollucci <pgollucci@p6m7g8.com>
