#!/bin/bash

userdel nginx

rm -rf /etc/nginx 
rm -rf /usr/lib64/nginx/modules
rm -rf /usr/sbin/nginx
rm -rf /etc/systemd/system/nginx.service
