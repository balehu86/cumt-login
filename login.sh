#!/bin/bash

time=$(date '+%y-%m-%d %H:%M:%S')
destination_ip=www.runoob.com
user_account='02210000%40cmcc'
user_password='00000000'

########login method########
login(){
    if [ $1 != '网络正常' ]
    then
        send $1 0
        resault=$(curl -X GET 'http://10.2.5.251:801/eportal/?c=Portal&a=login&login_method=1&user_account=02210000%40cmcc&user_password=00000000&wlan_user_ip=&wlan_user_mac=70:E2:4C:68:3E:A9')
        if [ $resault == '({"result":"1","msg":"认证成功"})' ]
        then
            send '网络异常，已认证成功'
        else
            send '网络异常，认证失败' 0
        fi
    fi
}

########send message to telegram bot and echo into log file########
send(){
    echo $1 $2
    if [ "$2" != '0' ]
    then
        curl -s -X GET "https://api.telegram.org/bot5329000000:AAH8dHkIRpwPxxhSfCiGWoCikpMkaW00000/sendMessage?chat_id=1217560000&text="$1 > /dev/null 2>&1
    fi
    ##print log to logfile
    echo $time  $1 > /tmp/log/school.sh.log
    echo $time  $1 >> /root/school.sh.log
}

if ping -c1 $destination_ip &>/dev/null
then
    send "网络正常！"
else
    #/etc/init.d/openclash stop
    login "网络异常，尝试认证"
    if ![ping -c1 $destination_ip &>/dev/null]
    then
        login "认证失败" 0
    fi
fi
