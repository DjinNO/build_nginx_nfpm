#!/bin/bash
adduser --system --no-create-home --user-group -s /sbin/nologin nginx
cat <<EOF > /etc/logrotate.d/nginx
/var/log/nginx/*log {
    create 0644 nginx nginx
    daily
    rotate 10
    missingok
    notifempty
    compress
    sharedscripts
    postrotate
        /bin/kill -USR1 `cat /run/nginx.pid 2>/dev/null` 2>/dev/null || true
    endscript
}
EOF
