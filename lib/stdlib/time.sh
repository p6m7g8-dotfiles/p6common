p6_time() {
    true
}
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
# p6_time() {
#     local t0="$1"
#     local t1="$2"
#     local msg="$3"

#     local delta
#     if [ -n "$t0" ] && [ -n "$t1" ]; then
#         delta=$(($t1 - $t0))
#         delta=$(printf "%.3f" "$delta")
#         p6_echo "p6_time: $delta $msg" >>/tmp/p6/time.log
#     fi
# }
