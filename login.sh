#!/bin/bash

time=$(date '+%y-%m-%d %H:%M:%S')
destination_ip=www.runoob.com

##login method
login(){
    curl -X GET 'http://10.2.5.251:801/eportal/?c=Portal&a=login&login_method=1&user_account=02210000%40cmcc&user_password=00000000&wlan_user_ip=&wlan_user_mac=00:00:00:00:00:A9'
}
send(){
    echo $1
    curl -s -X GET "https://api.telegram.org/bot5329391020:AAH8dHkIRpwPxxhSfCiGWoCikpMkaW00000/sendMessage?chat_id=1217500000&text="$1
    ##print log to logfile
    echo $1  $time > /tmp/log/school.sh.log
    echo $1  $time >> /root/school.sh.log
}

if ping -c1 $destination_ip &>/dev/null
then
    send "网络正常"
else
    #/etc/init.d/openclash stop
    #send "尝试认证"
    echo "尝试认证"
    login
    if ping -c1 $destination_ip &>/dev/null
    then
        send "认证成功"
    else
        send "认证失败"
    fi
fi
