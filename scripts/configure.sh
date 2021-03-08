#!/bin/bash

./configure --prefix=/etc/nginx \
--sbin-path=/usr/sbin/nginx \
--modules-path=/usr/lib64/nginx/modules \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--with-http_realip_module \
--with-http_ssl_module \
--with-http_gzip_static_module \
--with-http_stub_status_module \
--with-http_secure_link_module \
--with-threads \
--with-http_slice_module \
--with-compat \
--with-file-aio \
--with-http_v2_module \
--with-http_gunzip_module \
--with-http_auth_request_module \
--with-cc-opt="" \
--with-ld-opt="" \
--add-module=../nginx-module-vts-0.1.18 \
--add-module=../headers-more-nginx-module-0.33 \
--add-module=../ngx_aws_auth-1.1.1 \
--add-dynamic-module=../ngx_http_geoip2_module-3.3
