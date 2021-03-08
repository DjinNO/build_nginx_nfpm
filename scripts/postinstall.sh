#!/bin/bash

# Create nginx cached folder
mkdir -p /var/cache/nginx/{client_temp,proxy_temp,fastcgi_temp,uwsgi_temp,scgi_temp}

# Create vhost config folder
mkdir -p /etc/nginx/{conf.d,sites.d}

/usr/bin/systemctl preset nginx.service
