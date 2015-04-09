#!/bin/sh

prog=/usr/bin/vncpasswd
mypass=$1

/usr/bin/expect <<EOF
spawn "$prog"
expect "Password:"
send "$mypass\r"
expect "Verify:"
send "$mypass\r"
expect eof
exit
EOF