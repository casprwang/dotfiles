awk '!seen[$0]++' <(fre --sorted | grep "${PWD}*") <(fd -t f . -a)
