# -
矿大校园网自动登录，需要挂在Linux系统上，用cron做计划任务执行
openwrt用了openclash的使用openclash.login.sh，没有openclash的使用login.sh，区别就在于openclash打开时会影响登录，需要在登陆时关闭。需要登录信息通知发送到Telegram的，请在openclash.login.sh里修改，有被注释掉的两三行代码，可以自行研究如何使用Telegram的bot。
将：
user_account=02210000%40cmcc&user_password=123456789&wlan_user_ip=0.0.0.0&wlan_user_mac=00:00:00:00:00:00
账号为学号加运营商代号，例如：
中国移动：02210000%40cmcc
中国联通：02210000%40unicom
中国电信：02210000%40telecom
密码为密码
wlan_user_ip填你网页登录得到的IP，随便填一个有一定概率和别人冲突上不了网，自己正常登录看看给你什么ip就填什么，一般正常情况下，同一个人的账号下，同一个设备在同一地点ip是相同，但是比如宿舍和教室的ip不一样，宿舍一般10.4开头，教室10.5、10.6都有，所以最好是放在宿舍路由器上执行。比如，我用路由器连接一次校园网，电脑连接路由器，此时没有经过登录认证而无法上网，电脑输入
http://10.2.5.251/
正常填写账号密码登录，然后去路由器后台查看ip和mac，填入第八行，修改保存。然后在电脑上注销登录，恢复网络未登录状态。接着用bash执行login.sh文件，然后电脑随便打开bilibili看看有没有登陆成功，成功了就可以写cron的计划任务了。
chmod +x ./login.sh   #给login.sh执行权限，然后放入/usr/bin/目录下，cron这么填
20 7 * * 0-5 /usr/bin/login.sh

wlan_user_mac填你设备的mac，linux系统下
ifconfig
可以查ip和mac，mac也可以填00:00:00:00:00:00，有可能会出错
