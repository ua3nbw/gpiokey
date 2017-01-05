#!/bin/bash
function install_build_tools {
	echo "Build Utilities... "
        sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev libxslt1-dev libgd2-noxpm-dev libgeoip-dev     
}
function download_nginx_rtmp {
	
    echo "Download & unpack latest nginx-rtmp (you can also use http)... "
    cd /usr/src
    sudo git clone git://github.com/arut/nginx-rtmp-module.git

}
function download_nginx {
    echo "Download & unpack nginx (you can also use http)... "
    cd /usr/src
    sudo wget http://nginx.org/download/nginx-1.11.8.tar.gz
    sudo tar xzf nginx-1.11.8.tar.gz
    cd nginx-1.11.8
}
function build_nginx_rtmp {
     echo "Build nginx with nginx-rtmp "    
     sudo ./configure --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' --with-ld-opt=-Wl,-z,relro --prefix=/usr --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_sub_module --with-http_xslt_module --with-mail --with-mail_ssl_module --add-module=../nginx-rtmp-module --with-debug --with-http_flv_module --sbin-path=/usr/sbin --modules-path=/usr/lib/nginx/modules --without-http_rewrite_module --without-http_proxy_module
     sudo make
     sudo make install
}


install_build_tools
download_nginx_rtmp
download_nginx
build_nginx_rtmp

