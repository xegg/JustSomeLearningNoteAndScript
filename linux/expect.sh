#!/usr/bin/expect -f
ssh nw
expect "password: "
send "hello\r"
expect "$ "
send "exit\r"
