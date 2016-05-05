Gpu显示当前用户登陆时间
ac -d  

显示当前文件的统计
stat %(file)s

同时显示两个文件的日志
tail -f access.log -f error.log

ls | cpio -ov > test.cpio  # o-创建归档文件

apt-cache search %(apk)s 支持正则表达式

ddpkg -lpkg -l 列出安装包

vmstat 1 100

sysctl -a 
/etc/sysctl.conf
修改内核参数
sysctl -w {var=value}

renice %(priority)s -p %(id)s 修改进程优先级

od xxd 产看二进制文件

产看文件大小排行
sudo du -a / | sort -n -r | head -n 10 

修改全部文件
sed "s/designpatterns.strategy/g" 3 \*.java -i  
http://coolshell.cn/articles/9104.html

logrotate 
用于日志轮转, 邮件转发等功能, 简单快速

Send Signal to a Process Using Kill
ps -C a.out
kill -s USR1 pid

kill process
ps -ef | grep firefox #find process
pkill {process id}
xkill

Source
http://www.commandlinefu.com/commands/browse
https://wrfly.gitbooks.io/linux-101-hacks/content/hack-51_cpio.html
http://blog.commandlinekungfu.com/
