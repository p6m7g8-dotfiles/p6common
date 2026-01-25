# shellcheck shell=bash

main() {

	. ../p6common/lib/_bootstrap.sh
	p6_bootstrap "../p6common"

	p6_test_setup "172"

	p6_test_start "p6_dir_exists"
	(
		p6_test_run "p6_dir_exists"
		p6_test_assert_run_ok "no arg: dne" 1

		p6_test_run "p6_dir_exists" ""
		p6_test_assert_run_ok "\"\": dne" 1

		p6_test_run "p6_dir_exists" ''
		p6_test_assert_run_ok "'': dne" 1

		p6_test_run "p6_dir_exists" " "
		p6_test_assert_run_ok "\" \": dne" 1

		p6_test_run "p6_dir_exists" "' '"
		p6_test_assert_run_ok "\' \': dne" 1

		p6_test_run "p6_dir_exists" "/nonexistent"
		p6_test_assert_run_ok "/nonexistent: dne" 1

		p6_test_run "p6_dir_exists" "."
		p6_test_assert_run_ok ". is -d"
	)
	p6_test_finish

	p6_test_start "p6_dir_load"
	(
		p6_test_run "p6_dir_load"
		p6_test_assert_run_ok "no arg"

		p6_test_run "p6_dir_load" ""
		p6_test_assert_run_ok "\"\""

		p6_test_run "p6_dir_load" "dne"
		p6_test_assert_run_ok "dne"

		p6_test_run "p6_dir_load" "exists"
		p6_test_assert_run_ok "exists but not dir"

		p6_test_run "p6_dir_load" "dir"
		p6_test_assert_run_ok "exists but dir is empty"

		p6_test_run "p6_dir_load" "dir-1"
		p6_test_assert_run_ok "dir exists with 1 file"

		p6_test_run "p6_dir_load" "dir-2"
		p6_test_assert_run_ok "dir exists with 2 files"

		p6_test_run "p6_dir_load" "dir-sd"
		p6_test_assert_run_ok "dir exists with 1 sub dir"

		p6_test_run "p6_dir_load" "dir-sd-2"
		p6_test_assert_run_ok "dir exists with 1 sub dir and 2 files"

		p6_test_run "p6_dir_load" "dir-sd-2"
		p6_test_assert_run_ok "dir exists with 1 sub dir and 2 files"

		p6_test_run "p6_dir_load" "dir-sdw2-2"
		p6_test_assert_run_ok "dir exists with 1 sub dir with 2 files and 2 files"
	)
	p6_test_finish

	p6_test_start "p6_dir_list"
	(
		p6_test_run "p6_dir_list"
		p6_test_assert_run_ok "no arg"

		p6_test_run "p6_dir_list" ""
		p6_test_assert_run_ok "\"\""

		p6_test_run "p6_dir_list" "dne"
		p6_test_assert_run_ok "dne"

		p6_test_run "p6_dir_list" "exists"
		p6_test_assert_run_ok "exists but not dir"

		p6_test_run "p6_dir_list" "dir"
		p6_test_assert_run_ok "exists but dir is empty"

		p6_test_run "p6_dir_list" "dir-1"
		p6_test_assert_run_ok "dir exists with 1 file"

		p6_test_run "p6_dir_list" "dir-2"
		p6_test_assert_run_ok "dir exists with 2 files"

		p6_test_run "p6_dir_list" "dir-sd"
		p6_test_assert_run_ok "dir exists with 1 sub dir"

		p6_test_run "p6_dir_list" "dir-sd-2"
		p6_test_assert_run_ok "dir exists with 1 sub dir and 2 files"

		p6_test_run "p6_dir_list" "dir-sd-2"
		p6_test_assert_run_ok "dir exists with 1 sub dir and 2 files"

		p6_test_run "p6_dir_list" "dir-sdw2-2"
		p6_test_assert_run_ok "dir exists with 1 sub dir with 2 files and 2 files"

		p6_test_run "p6_dir_list" "dir1 dir2"
		p6_test_assert_run_ok "dir1 dir2"
	)
	p6_test_finish

	p6_test_start "p6_dirs_list"
	(
		p6_test_run "p6_dirs_list"
		p6_test_assert_run_ok "no arg"

		p6_test_run "p6_dirs_list" ""
		p6_test_assert_run_ok "\"\""

		p6_test_run "p6_dirs_list" "dne"
		p6_test_assert_run_ok "dne"

		p6_test_run "p6_dirs_list" "exists"
		p6_test_assert_run_ok "exists but not dirs"

		p6_test_run "p6_dirs_list" "dirs"
		p6_test_assert_run_ok "exists but dirs is empty"

		p6_test_run "p6_dirs_list" "dirs-1"
		p6_test_assert_run_ok "dirs exists with 1 file"

		p6_test_run "p6_dirs_list" "dirs-2"
		p6_test_assert_run_ok "dirs exists with 2 files"

		p6_test_run "p6_dirs_list" "dirs-sd"
		p6_test_assert_run_ok "dirs exists with 1 sub dirs"

		p6_test_run "p6_dirs_list" "dirs-sd-2"
		p6_test_assert_run_ok "dirs exists with 1 sub dirs and 2 files"

		p6_test_run "p6_dirs_list" "dirs-sd-2"
		p6_test_assert_run_ok "dirs exists with 1 sub dirs and 2 files"

		p6_test_run "p6_dirs_list" "dirs-sdw2-2"
		p6_test_assert_run_ok "dirs exists with 1 sub dirs with 2 files and 2 files"

		p6_test_run "p6_dirs_list" "dirs1 dirs2"
		p6_test_assert_run_ok "dirs1 dirs2"
	)
	p6_test_finish

	p6_test_start "p6_dir_list_recursive"
	(
		true
		# p6_test_run "p6_dir_list_recursive"
		# p6_test_assert_run_ok "no arg"

		# p6_test_run "p6_dir_list_recursive" ""
		# p6_test_assert_run_ok "\"\""

		# p6_test_run "p6_dir_list_recursive" "dne"
		# p6_test_assert_run_ok "dne"

		# p6_test_run "p6_dir_list_recursive" "exists"
		# p6_test_assert_run_ok "exists but not dirs"

		# p6_test_run "p6_dir_list_recursive" "dirs"
		# p6_test_assert_run_ok "exists but dirs is empty"

		# p6_test_run "p6_dir_list_recursive" "dirs-1"
		# p6_test_assert_run_ok "dirs exists with 1 file"

		# p6_test_run "p6_dir_list_recursive" "dirs-2"
		# p6_test_assert_run_ok "dirs exists with 2 files"

		# p6_test_run "p6_dir_list_recursive" "dirs-sd"
		# p6_test_assert_run_ok "dirs exists with 1 sub dirs"

		# p6_test_run "p6_dir_list_recursive" "dirs-sd-2"
		# p6_test_assert_run_ok "dirs exists with 1 sub dirs and 2 files"

		# p6_test_run "p6_dir_list_recursive" "dirs-sd-2"
		# p6_test_assert_run_ok "dirs exists with 1 sub dirs and 2 files"

		# p6_test_run "p6_dir_list_recursive" "dirs-sdw2-2"
		# p6_test_assert_run_ok "dirs exists with 1 sub dirs with 2 files and 2 files"

		# p6_test_run "p6_dir_list_recursive" "dirs1 dirs2"
		# p6_test_assert_run_ok "dirs1 dirs2"
	)
	p6_test_finish

	p6_test_start "p6_dir_rmrf"
	(
		p6_test_run "p6_dir_rmrf"
		p6_test_assert_run_ok "no arg" 0 "p6_dir: rmrf(): Cowardly refusing to shoot us in the foot []"

		p6_test_run "p6_dir_rmrf" ""
		p6_test_assert_run_ok "\"\"" 0 "p6_dir: rmrf(): Cowardly refusing to shoot us in the foot []"

		p6_test_run "p6_dir_rmrf" "dne"
		p6_test_assert_run_ok "dne"

		p6_test_run "p6_dir_rmrf" "dir"
		p6_test_assert_run_ok "dir"

		p6_test_run "p6_dir_rmrf" "file"
		p6_test_assert_run_ok "file"

		p6_test_run "p6_dir_rmrf" "link"
		p6_test_assert_run_ok "link"

		p6_test_skip "not bold enough for rm -rf /"
		#	p6_test_run "p6_dir_rmrf" "/"
		#	p6_test_assert_run_ok "/"
	)
	p6_test_finish

	p6_test_start "p6_dir_mk"
	(
		# p6_test_run "p6_dir_mk"
		# p6_test_assert_run_ok "no arg" 64 "" "usage: mkdir [-pv] [-m mode] directory ..."

		# p6_test_run "p6_dir_mk" ""
		# p6_test_assert_run_ok "\"\""

		p6_test_run "p6_dir_mk" "exists"
		p6_test_assert_run_ok "exists"

		p6_test_run "p6_dir_mk" "new"
		p6_test_assert_run_ok "new"

		p6_test_run "p6_dir_mk" "1/2"
		p6_test_assert_run_ok "1/2"
	)
	p6_test_finish

	p6_test_start "p6_dir_cp"
	(
		true
		# p6_test_run "p6_dir_cp"
		# p6_test_assert_run_ok "no arg"

		# p6_test_run "p6_dir_cp" "one"
		# p6_test_assert_run_ok "one arg"

		# p6_test_run "p6_dir_cp" "one two"
		# p6_test_assert_run_ok "two args but dne"

		# p6_test_run "p6_dir_cp" "one two"
		# p6_test_assert_run_ok "two args but dne one"

		# p6_test_run "p6_dir_cp" "one two"
		# p6_test_assert_run_ok "two args and dne two"

		# p6_test_run "p6_dir_cp" "one two"
		# p6_test_assert_run_ok "two args but exists two"

		# p6_test_run "p6_dir_cp" "one two"
		# p6_test_assert_run_ok "two args dne one but exists two"

		# p6_test_run "p6_dir_cp" "file dir"
		# p6_test_assert_run_ok "two args file dir"

		# p6_test_run "p6_dir_cp" "dir file"
		# p6_test_assert_run_ok "two args dir file"
	)
	p6_test_finish

	p6_test_start "p6_dir_mv"
	(
		true
		# p6_test_run "p6_dir_mv"
		# p6_test_assert_run_ok "no arg"

		# p6_test_run "p6_dir_mv" "one"
		# p6_test_assert_run_ok "one arg"

		# p6_test_run "p6_dir_mv" "one two"
		# p6_test_assert_run_ok "two args but dne"

		# p6_test_run "p6_dir_mv" "one two"
		# p6_test_assert_run_ok "two args but dne one"

		# p6_test_run "p6_dir_mv" "one two"
		# p6_test_assert_run_ok "two args and dne two"

		# p6_test_run "p6_dir_mv" "one two"
		# p6_test_assert_run_ok "two args but exists two"

		# p6_test_run "p6_dir_mv" "one two"
		# p6_test_assert_run_ok "two args dne one but exists two"

		# p6_test_run "p6_dir_mv" "file dir"
		# p6_test_assert_run_ok "two args file dir"

		# p6_test_run "p6_dir_mv" "dir file"
		# p6_test_assert_run_ok "two args dir file"
	)
	p6_test_finish

	p6_test_start "p6_dir_cd"
	(
		true
		# p6_test_run "p6_dir_cd"
		# p6_test_assert_run_ok "no arg"

		# p6_test_run "p6_dir_cd" "one"
		# p6_test_assert_run_ok "one arg but dne"

		# p6_test_run "p6_dir_cd" "one two"
		# p6_test_assert_run_ok "two args but dne two"

		# p6_test_run "p6_dir_cd" "one" "two"
		# p6_test_assert_run_ok "two args but dne one"

		# p6_test_run "p6_dir_cd" "file"
		# p6_test_assert_run_ok "file"

		# p6_test_run "p6_dir_cd" "ilink"
		# p6_test_assert_run_ok "link invalid"

		# p6_test_run "p6_dir_cd" "vlink"
		# p6_test_assert_run_ok "link valid"

		# p6_test_run "p6_dir_cd" "dir"
		# p6_test_assert_run_ok "dir"
	)
	p6_test_finish

	p6_test_start "p6_dir__debug"
	(
		p6_test_run "p6_dir__debug ping"
		p6_test_assert_run_ok "debug"
	)
	p6_test_finish

	p6_test_start "p6_dir_list_recursive"
	(
		p6_test_run "mkdir -p root/sub; echo a > root/a.txt; echo b > root/sub/b.txt; p6_dir_list_recursive root | p6_filter_translate_space_to_newline | p6_filter_sort"
		p6_test_assert_run_ok "list_recursive" 0 "root/a.txt
root/sub/b.txt"
	)
	p6_test_finish

	p6_test_start "p6_dir_cp"
	(
		p6_test_run "mkdir -p src; echo hi > src/file.txt; p6_dir_cp src dst"
		p6_test_assert_run_rc "cp: rc" 0
		p6_test_assert_file_exists "dst/file.txt" "cp: dst file exists"
		p6_test_assert_file_exists "src/file.txt" "cp: src file exists"
	)
	p6_test_finish

	p6_test_start "p6_dir_mv"
	(
		p6_test_run "mkdir -p src; echo hi > src/file.txt; p6_dir_mv src dst"
		p6_test_assert_run_rc "mv: rc" 0
		p6_test_assert_dir_exists "dst" "mv: dst dir exists"
		p6_test_assert_dir_not_exists "src" "mv: src dir removed"
	)
	p6_test_finish

	p6_test_start "p6_dir_cd"
	(
		local wd=$(pwd)
		p6_test_run "mkdir -p go; p6_dir_cd go; pwd"
		p6_test_assert_run_ok "cd" 0 "$wd/go"
	)
	p6_test_finish

	p6_test_start "p6_dir_replace_in"
	(
		p6_test_run "mkdir -p work; echo foo > work/file.txt; cd work; p6_dir_replace_in . foo bar; cat file.txt"
		p6_test_assert_run_ok "replace_in" 0 "bar"
	)
	p6_test_finish

	p6_test_teardown
}

main "$@"
