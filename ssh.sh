#!/usr/bin/expect  -f 
set hs [lindex $argv 0] 
set timeout 10
send_user hs
spawn ssh-keygen
expect "*Enter*"
send "\n"
expect "*Enter*"
send "\n"
expect "*Enter*"
send "\n"

spawn ssh-copy-id $hs
expect "*yes/no*"
send "yes\n"
expect "*password*"
send "sdbadmin\n"

expect eof
