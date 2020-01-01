ec () {
    (is_wifi)
    local t1=$?
    wifi on
    ssh -yi '~/test3.pem' ubuntu@18.221.114.144
    if [ $t1 -eq 0 ]; then
        wifi on
    else
        wifi off
    fi
}

up () {
    (is_wifi)
    local t1=$?
    wifi on
    rsync -zavh -e "ssh -yi ~/test3.pem" ~/tmp/notes ubuntu@18.221.114.144:/home/ubuntu/
    if [ $t1 -eq 0 ]; then
        wifi on
    else
        wifi off
    fi
}

down () {
    (is_wifi)
    local t1=$?
    wifi on
    rsync -zavh -e "ssh -yi ~/test3.pem" ubuntu@18.221.114.144:/home/ubuntu/notes ~/tmp/
    if [ $t1 -eq 0 ]; then
        wifi on
    else
        wifi off
    fi
}

