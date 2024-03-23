# p6common

## Table of Contents


### p6common
- [p6common](#p6common)
  - [Badges](#badges)
  - [Distributions](#distributions)
  - [Summary](#summary)
  - [Contributing](#contributing)
  - [Code of Conduct](#code-of-conduct)
  - [Usage](#usage)
  - [Author](#author)

### Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/p6m7g8/p6common)
[![Mergify](https://img.shields.io/endpoint.svg?url=https://gh.mergify.io/badges/p6m7g8/p6common/&style=flat)](https://mergify.io)
[![codecov](https://codecov.io/gh/p6m7g8/p6common/branch/master/graph/badge.svg?token=14Yj1fZbew)](https://codecov.io/gh/p6m7g8/p6common)
[![Known Vulnerabilities](https://snyk.io/test/github/p6m7g8/p6common/badge.svg?targetFile=package.json)](https://snyk.io/test/github/p6m7g8/p6common?targetFile=package.json)
[![Gihub repo dependents](https://badgen.net/github/dependents-repo/p6m7g8/p6common)](https://github.com/p6m7g8/p6common/network/dependents?dependent_type=REPOSITORY)
[![Gihub package dependents](https://badgen.net/github/dependents-pkg/p6m7g8/p6common)](https://github.com/p6m7g8/p6common/network/dependents?dependent_type=PACKAGE)

## Summary

## Contributing

- [How to Contribute](CONTRIBUTING.md)

## Code of Conduct

- [Code of Conduct](https://github.com/p6m7g8/.github/blob/master/CODE_OF_CONDUCT.md)

## Usage


### Aliases


### Functions

### p6common:

#### p6common/init.zsh:

- p6df::modules::p6common::init(_module, dir)


### cicd:

#### cicd/build.sh:

- p6_cicd_build_run()

#### cicd/doc.sh:

- p6_cicd_doc_gen()

#### cicd/release.sh:

- code  = p6_cicd_release_make()

#### cicd/test.sh:

- p6_cicd_test_benchmark()
- p6_cicd_tests_run()


### math:

#### math/math.sh:

- code rc = p6_math_gt(a, b)
- code rc = p6_math_gte(a, b)
- code rc = p6_math_lt()
- code rc = p6_math_lte(a, b)
- int result = p6_math_inc(a, [b=1])
- int rv = p6_math_sub(a, b)
- p6_math_dec(a)


### network:

#### network/download.sh:

- path dest = p6_network_file_download()

#### network/network.sh:

- str ip = p6_network_ip_public()

#### network/remote.sh:

- p6_remote_ssh_do(cmd)

#### network/ssh.sh:

- code rc = p6_ssh_key_check(priv, test_pub)
- p6_ssh_key_add(key_file_priv)
- p6_ssh_key_delete(key_file_priv)
- p6_ssh_key_fingerprint()
- p6_ssh_key_make(key_file_priv)
- p6_ssh_key_pub_from_priv(key_file_priv, [key_file_pub=${key_file_priv])
- p6_ssh_key_remove(key_file_priv, [key_file_pub=${key_file_priv])
- p6_ssh_keys_chmod(key_file_priv)


### openssl:

#### openssl/ciphers.sh:

- str str = p6_openssl_ciphers()

#### openssl/req.sh:

- p6_openssl_req_csr_create()

#### openssl/s_client.sh:

- p6_openssl_alias(host, port, ...)
- p6_openssl_alt_name(host, port, ...)
- p6_openssl_not_after(host, port, ...)
- p6_openssl_not_before(host, port, ...)
- p6_openssl_not_purpose(host, port, ...)
- p6_openssl_purpose(host, port, ...)
- p6_openssl_s_client_connect()
- p6_openssl_serial(host, port, ...)
- p6_openssl_subject(host, port, ...)

#### openssl/s_server.sh:

- p6_openssl_s_server_run()

#### openssl/util.sh:

- p6_openssl_certificate_create()

#### openssl/version.sh:

- str str = p6_openssl_version()

#### openssl/x509.sh:

- p6_openssl_req_cert_self_signed_create()


### p6common/lib:


### stdio:

#### stdio/color.sh:

- p6_color_hex_to_d16b(hex, ord)
- p6_color_ize(color_fg, color_bg, msg)
- p6_color_opacity_factor()
- p6_color_say(color_fg, color_bg, msg)
- size_t code = p6_color_to_code(color)
- str rgb = p6_color_name_to_rgb(name)

#### stdio/dir.sh:

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

#### stdio/file.sh:

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
- p6_file_repalce(file, sed_cmd)
- p6_file_replace(file, sed_cmd)
- p6_file_rmf(file)
- p6_file_symlink(to, from)
- p6_file_unlink(file)
- p6_file_write(file, contents)
- path path/$cmd = p6_file_cascade(cmd, exts, ...)
- str line = p6_file_line_first(file)
- str lines = p6_file_lines_except_first(file)
- str lines = p6_file_lines_first(file, n)
- str lines = p6_file_lines_last(file, n)

#### stdio/interactive.sh:

- code 42 = p6_int_confirm_ask()
- str PASSWORD = p6_int_password_read()

#### stdio/io.sh:

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

#### stdio/log-prod.sh:

- p6_log(msg)
- p6_log_disable()
- p6_log_enable()

#### stdio/verbose.sh:

- p6_verbose(level)


### stdlib:

#### stdlib/alias.sh:

- p6_alias(from, to)
- p6_alias_cd_dirs(dir)

#### stdlib/ctl.sh:

- p6_ctl_cmd_build(dockerfile)
- p6_ctl_cmd_docker_build()
- p6_ctl_cmd_docker_test()
- p6_ctl_cmd_install([home=pgollucci/home])
- p6_ctl_cmd_test()
- p6_ctl_run(...)
- p6_ctl_usage()

#### stdlib/diag.sh:

- p6_diagnostics()

#### stdlib/dryrunning.sh:

- bool rv = p6_dryrunning()

#### stdlib/dt.sh:

- size_t epoch_seconds = p6_dt_now_epoch_seconds()
- size_t modified_epoch_seconds = p6_dt_mtime(file)
- str dt = p6_dt_now()
- str dt = p6_dt_tomorrow()
- str dt = p6_dt_yesterday()

#### stdlib/edit.sh:

- code ? = p6_edit_editor_run()
- path scratch_file = p6_edit_scratch_file_create(msg)

#### stdlib/env.sh:

- p6_env_export(var, val)
- p6_env_export_un(var)
- p6_env_list(glob)
- p6_env_list_p6()

#### stdlib/lang.sh:

- str prefix = p6_lang_cmd_2_env(cmd)
- str rcmd = p6_lang_env_2_cmd(prefix)
- str v = p6_lang_version(prefix)
- str ver = p6_lang_system_version(prefix)

#### stdlib/misc.sh:

- p6_pgs()
- p6_xclean()
- size_t len = p6_len(s)

#### stdlib/os.sh:

- str name = p6_os_name()

#### stdlib/path.sh:

- p6_cdpath_current()
- p6_path_current()
- p6_path_default()
- true  = p6_path_if(dir)

#### stdlib/retry.sh:

- p6_retry_delay_doubling()
- p6_retry_delay_log()
- size_t i = p6_retry_delay(type, i)

#### stdlib/run.sh:

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

#### stdlib/template.sh:

- str processed = p6_template_process(infile, ...)

#### stdlib/time-prod.sh:

- p6_time(t0, msg)

#### stdlib/transients.sh:

- code rc = p6_transient_is(dir)
- code rc = p6_transient_persist_is(dir)
- p6_transient_delete(dir, [handler_name=])
- p6_transient_persist(dir)
- p6_transient_persist_un(dir)
- path file = p6_transient_create_file(file_name)
- str  = p6_transient_create(dir_name, [len=4])

#### stdlib/unroll.sh:

- p6_unroll_function(function)
- p6_unroll_functions()


### string:

#### string/filter.sh:

- p6_filter_alnum_and_underscore_strip()
- p6_filter_alnum_strip()
- p6_filter_double_quote_strip()
- p6_filter_exclude(selector)
- p6_filter_first(n)
- p6_filter_from_end(n)
- p6_filter_last(n)
- p6_filter_leading_and_trailing_spaces_strip()
- p6_filter_leading_spaces_strip()
- p6_filter_pluck_column(n, [split=])
- p6_filter_pluck_column_to_end(n, [split= ])
- p6_filter_pluck_column_when_row_selected(n, selector, [split=])
- p6_filter_quotes_strip()
- p6_filter_remove_trailing_slash()
- p6_filter_reverse()
- p6_filter_select(selector, [flag_case=])
- p6_filter_select_and_after(selector, count)
- p6_filter_single_quote_strip()
- p6_filter_sort()
- p6_filter_spaces_strip()
- p6_filter_to_underscore(glob)
- p6_filter_trailing_spaces_strip()
- p6_filter_translate_parens_to_slash()
- p6_filter_translate_space_to_underscore()
- p6_filter_translate_trailing_slash_bang_to_bang()

#### string/json.sh:

- p6_json_eval(json, ...)
- p6_json_from_file(file)

#### string/string.sh:

- bool rv = p6_string_blank(str)
- bool rv = p6_string_eq(str, val)
- size_t len = p6_string_len(str)
- str str_a = p6_string_append(str, add, [sep= ])
- str str_ic = p6_string_init_cap(str)
- str str_lc = p6_string_lc(str)
- str str_r = p6_string_replace(str, from, to)
- str str_uc = p6_string_uc(str)

#### string/tokens.sh:

- p6_token_encode_base64(string)
- p6_token_sha256(string)
- str hashed = p6_token_hash(string)
- str pass = p6_token_passwd(len)
- str token = p6_token_random(len)

#### string/uri.sh:

- path name = p6_uri_name(uri)
- path name = p6_uri_path(uri)

#### string/word.sh:

- true  = p6_word_in(word, ..., words)
- words result = p6_word_not(a, b)
- words words = p6_word_unique(...)


### test:

#### test/api.sh:

- p6_test_bail(reason)
- p6_test_diagnostic(msg)
- p6_test_finish()
- p6_test_not_ok(description)
- p6_test_ok(description)
- p6_test_setup()
- p6_test_skip(description, reason)
- p6_test_start(block)
- p6_test_teardown()
- p6_test_todo(val, const, description, reason)

#### test/bench.sh:

- p6_test_bench()

#### test/harness.sh:

- p6_test_harness_test_run()
- p6_test_harness_tests_run(dir)
- p6_test_harness_tests_run_bats(dir)
- p6_test_harness_tests_run_local()


### test/asserts:

#### test/asserts/aserts.sh:

- p6_test_assert_blank(val, description, reason)
- p6_test_assert_contains(val, const, description, reason)
- p6_test_assert_dir_exists(val, description, reason)
- p6_test_assert_dir_not_exists(val, description, reason)
- p6_test_assert_eq(val, const, description, reason)
- p6_test_assert_file_exists(val, description, reason)
- p6_test_assert_file_matches(file1, file2, description, reason)
- p6_test_assert_file_not_exists(val, description, reason)
- p6_test_assert_len(val, const, description, reason)
- p6_test_assert_not_blank(val, description, reason)
- p6_test_assert_not_contains(val, const, description, reason)
- p6_test_assert_not_eq(val, const, description, reason)
- p6_test_assert_run_no_output(description, reason)
- p6_test_assert_run_no_stderr(description, reason)
- p6_test_assert_run_no_stdout(description, reason)
- p6_test_assert_run_not_ok(description, reason)
- p6_test_assert_run_ok(description, [rv=0], [stdout=], [stderr=])
- p6_test_assert_run_rc(description, rv)
- p6_test_run()
- p6_test_run_rc()
- p6_test_run_stderr()
- p6_test_run_stdout()


### test/backends:

#### test/backends/tap.sh:

- p6_test_tap_bail_out(reason)
- p6_test_tap_block(block)
- p6_test_tap_diagnostic(msg)
- p6_test_tap_not_ok(description, reason)
- p6_test_tap_ok(description, reason)
- p6_test_tap_plan()
- p6_test_tap_shell()
- p6_test_tap_skip(description, reason)
- p6_test_tap_todo_bonus(description, reason)
- p6_test_tap_todo_planned(description, reason)


### types:

#### types/return.sh:

- code  = p6_return_false()
- code  = p6_return_true()
- code bool = p6_return_bool(bool)
- code rc = p6_return_code_as_code(rc)
- code rc = p6_return_code_as_value(rc)
- p6_return_float(float)
- p6_return_int(int)
- p6_return_path(path)
- p6_return_size_t(size_t)
- p6_return_str(str)
- p6_return_void()
- p6_return_words(words)
- true  = p6_return(rv)



## Hier
```text
.
├── _bootstrap.sh
├── cicd
│   ├── build.sh
│   ├── deploy.sh
│   ├── doc.sh
│   ├── release.sh
│   └── test.sh
├── math
│   └── math.sh
├── network
│   ├── download.sh
│   ├── network.sh
│   ├── remote.sh
│   └── ssh.sh
├── openssl
│   ├── ciphers.sh
│   ├── debug.sh
│   ├── req.sh
│   ├── s_client.sh
│   ├── s_server.sh
│   ├── util.sh
│   ├── verify.sh
│   ├── version.sh
│   └── x509.sh
├── stdio
│   ├── color.sh
│   ├── debug-debug.sh
│   ├── debug-prod.sh
│   ├── dir.sh
│   ├── file.sh
│   ├── interactive.sh
│   ├── io.sh
│   ├── log-debug.sh
│   ├── log-prod.sh
│   └── verbose.sh
├── stdlib
│   ├── alias.sh
│   ├── const.sh
│   ├── ctl.sh
│   ├── diag.sh
│   ├── dryrunning.sh
│   ├── dt.sh
│   ├── edit.sh
│   ├── env.sh
│   ├── lang.sh
│   ├── misc.sh
│   ├── os.sh
│   ├── path.sh
│   ├── retry.sh
│   ├── run.sh
│   ├── template.sh
│   ├── time-debug.sh
│   ├── time-prod.sh
│   ├── transients.sh
│   └── unroll.sh
├── string
│   ├── filter.sh
│   ├── json.sh
│   ├── string.sh
│   ├── tokens.sh
│   ├── uri.sh
│   └── word.sh
├── test
│   ├── _bootstrap.sh
│   ├── _colors.sh
│   ├── _util.sh
│   ├── api.sh
│   ├── asserts
│   │   └── aserts.sh
│   ├── backends
│   │   └── tap.sh
│   ├── bench.sh
│   └── harness.sh
└── types
    └── return.sh

12 directories, 64 files
```
## Author

Philip M . Gollucci <pgollucci@p6m7g8.com>
