function runOnce(){
  { /usr/bin/time $2 ; } 2> /tmp/o 1> /dev/null
  printf "$1 = "
  cat /tmp/o | awk -v N=1 '{print $N"s"}'
}
runOnce "$1" "$2"