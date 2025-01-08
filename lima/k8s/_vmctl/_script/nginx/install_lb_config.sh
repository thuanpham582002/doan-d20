# Remove default config
has_stream_module=$(nginx -V 2>&1 | grep -q "with-stream=dynamic")
cat <<EOF > /etc/nginx/nginx.conf
user www-data;
worker_processes auto;
pid /run/nginx.pid;
error_log /var/log/nginx/error.log;
include /etc/nginx/modules-enabled/*.conf;

EOF
if [ -n "$has_stream_module" ]; then
    cat <<EOF >> /etc/nginx/nginx.conf
load_module /usr/lib/nginx/modules/ngx_stream_module.so;
EOF
fi

cat <<EOF >> /etc/nginx/nginx.conf
events {
        worker_connections 4096;
}

stream {
    upstream app_node {
        server 192.168.105.51:30443;
        server 192.168.105.53:30443;
        server 192.168.105.54:30443;
    }
    upstream app_node_http {
        server 192.168.105.51:30080;
        server 192.168.105.53:30080;
        server 192.168.105.54:30080;
    }

    server {
        listen 443;
        proxy_pass app_node;
    }

    server {
        listen 80;
        proxy_pass app_node_http;
    }
}
EOF

nginx -t
nginx -s reload