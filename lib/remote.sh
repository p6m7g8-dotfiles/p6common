#    ssh -v -N -o ConnectTimeOut=2 -o BatchMode=yes $host 'echo' # >/dev/null 2>&1

p6_remote_ssh_do() {
  local host="$1"

  p6_run_read_cmd ssh $host
}
