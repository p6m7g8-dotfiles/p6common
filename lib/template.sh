p6_template_fill_in() {
    local infile="$1"
    local outfile="$2"
    local q_flag="$3"
    shift 3

    p6_file_copy "$infile" "$outfile"
    local sed_re
    local save_ifs=$IFS
    IFS=^
    for sed_re in $(echo $@); do
	if [ x"$q_flag" = x"no_quotes" ]; then
	    p6_debug "N: sed -i ''  -e $sed_re $outfile"
	    sed -i '' -e $sed_re $outfile
	else
	    p6_debug "Q: sed -i ''  -e \"$sed_re\" $outfile"
	    sed -i '' -e "$sed_re" $outfile
	fi
    done
    IFS=$save_ifs
}

p6_template_fill_args() {
    local mark="$1"
    local sep="$2"
    local split="$3"
    shift 3

    local pair
    local args
    local save_ifs=$IFS
    IFS=$split
    for pair in $(echo $@); do
	local k=$(echo $pair | cut -f 1 -d '=')
	local v=$(echo $pair | cut -f 2- -d '=')

	args="${args}s${sep}${mark}${k}${mark}${sep}${v}${sep}g^"
    done
    IFS=$save_ifs

    echo $args | sed -e 's,\^$,,'
}

p6_template_process() {
    local infile="$1"
    shift 1

    local dir=$(p6_transient_create "aws.tmpl")
    local outfile="$dir/outfile"

    local fill_args=$(p6_template_fill_args "" "," " " "$@")

    p6_template_fill_in "$infile" "$outfile" "" "$fill_args"
    p6_file_display "$outfile"

    p6_transient_delete "$outfile"
}