#!/bin/bash

time=$(date '+%y-%m-%d %H:%M:%S')
destination_ip=www.runoob.com

##login method
login(){
        curl -s -X GET 'http://10.2.5.251:801/eportal/?c=Portal&a=login&login_method=1&user_account=02210765%40cmcc&user_password=OhMaU286&wlan_user_ip=10.4.248.62&wlan_user_mac=70:E2:4C:68:3E:A9'
}

if ping -c1 $destination_ip &>/dev/null
then
        echo "网络正常"
        curl -X GET "https://api.telegram.org/bot5329390000:AAH8dHkIRpwPxxhSfCiGWoCikpMkaW00000/sendMessage?chat_id=1217560000&text=网络正常"
else
        #/etc/init.d/openclash stop
        echo "无网络，尝试登录"
        login
        if ping -c1 $destination_ip &>/dev/null
        then
                echo "认证成功"
                curl -X GET "https://api.telegram.org/bot5329390000:AAH8dHkIRpwPxxhSfCiGWoCikpMkaW00000/sendMessage?chat_id=1217560000&text=已成功登录"
        fi
        #/etc/init.d/openclash start
fi

##print log to logfile
echo '认证成功   '$time > /tmp/log/school.sh.log
echo '认证成功   '$time >> /root/school.sh.log
