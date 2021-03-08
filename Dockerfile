FROM centos:7.9.2009

#Step 1: Install dependencies
ENV NFPM_VERSION="v2.2.4"

RUN yum update -y && yum groupinstall -y 'Development Tools'
RUN yum install -y perl perl-devel perl-ExtUtils-Embed libxslt \
                libxslt-devel libxml2 \
                libxml2-devel gd gd-devel \
                GeoIP GeoIP-devel \
                wget rpmdevtools \
                libmaxminddb-devel \
                redhat-lsb-core \
                openssl-devel \ 
                pcre-devel \
                https://github.com/goreleaser/nfpm/releases/download/$NFPM_VERSION/nfpm_amd64.rpm
                
#Step 2: Download modules
ENV VTS_MODULE_VERSION="0.1.18"
ENV HEADERS_MORE_MODULE_VERSION="0.33"
ENV AWX_AUTH_MODULE_VERSION="1.1.1"
ENV GEOIP2_MODULE_VERSION="3.3"

WORKDIR /tmp

RUN wget https://github.com/vozlt/nginx-module-vts/archive/v$VTS_MODULE_VERSION.tar.gz -O ./nginx-module-vts.tar.gz && tar xsf ./nginx-module-vts.tar.gz && \
       wget https://github.com/openresty/headers-more-nginx-module/archive/v$HEADERS_MORE_MODULE_VERSION.tar.gz -O ./headers-more-nginx-module.tar.gz && tar xsf ./headers-more-nginx-module.tar.gz && \
       wget https://github.com/anomalizer/ngx_aws_auth/archive/$AWX_AUTH_MODULE_VERSION.tar.gz -O ./ngx_aws_auth.tar.gz && tar xsf ./ngx_aws_auth.tar.gz && \
       wget https://github.com/leev/ngx_http_geoip2_module/archive/$GEOIP2_MODULE_VERSION.tar.gz -O ./ngx_http_geoip2_module.tar.gz && tar xsf ./ngx_http_geoip2_module.tar.gz

#Step 3: Install Nginx
ENV NGINX_VERSION="1.18.0"
ENV PACKAGE_VERSION="0.0.1"

RUN wget https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz && tar xsf nginx-$NGINX_VERSION.tar.gz

COPY ./scripts/configure.sh /tmp/nginx-$NGINX_VERSION/

RUN chmod +x /tmp/nginx-$NGINX_VERSION/configure.sh &&\
       cd /tmp/nginx-$NGINX_VERSION/ && ./configure.sh && make install DESTDIR=/tmp/installdir &&\
       rm -f /tmp/installdir/etc/nginx/nginx.conf

#Step 4: Create package
COPY ./nfpm.yaml .
COPY ./files ./files
COPY ./scripts ./scripts
RUN mkdir -p /tmp/artifact

CMD nfpm pkg --packager rpm --target /tmp/artifact/nginx-$NGINX_VERSION-$PACKAGE_VERSION.rpm
