#!/bin/bash

#login method
login(){
        curl -s -X GET 'http://10.2.5.251:801/eportal/?c=Portal&a=login&login_method=1&user_account=02210000%40cmcc&user_password=123456789&wlan_user_ip=0.0.0.0&wlan_user_mac=00:00:00:00:00:00'
}

#judge the net work well or not
destination_ip=www.runoob.com

if ping -c1 $destination_ip &>/dev/null 
then  
netstatu=online
else 
netstatu=offline 
fi
 
if [ $netstatu == 'offline' ]
then
        login
fi

#get the time
time=$(date '+%y-%m-%d %H:%M:%S')

#print log to logfile
echo '认证成功   '$time > /tmp/log/login.log
echo '认证成功   '$time >> /root/login.sh.log
#echo "认证成功"
