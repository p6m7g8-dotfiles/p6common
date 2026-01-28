######################################################################
#<
#
# Function: p6_time(t0, t1, msg)
#
#  Args:
#	t0 -
#	t1 -
#	msg -
#
#>
######################################################################
p6_time() {
    local t0="$1"
    local msg="$2"

    local t1="$EPOCHREALTIME"

    local delta
    if p6_string_blank_NOT "$t0" && p6_string_blank_NOT "$t1"; then
        delta=$(($t1 - $t0))
        delta=$(printf "%.3f" "$delta")
        p6_echo "p6_time: $delta $msg" >>/tmp/p6/time.log
    fi
}
