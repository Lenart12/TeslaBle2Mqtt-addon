#!/usr/bin/with-contenv bashio

# Read options from the configuration
optProxyPort=5667 # Internal port for the proxy
optBtAdapter="$(bashio::config 'bt_adapter' 'hci0')"
optScanTimeout="$(bashio::config 'scan_timeout' '1')"
optLogLevel="$(bashio::config 'log_level' 'INFO')"
optCacheMaxAge="$(bashio::config 'cache_max_age' '5')"

# Addon information
selfRepo=$(bashio::addon.repository)
reportedVersion=$(bashio::addon.version)
selfSlug=$(bashio::addons "self" "addons.self.slug" '.slug')

# Ingress configuration
ingressPort=$(bashio::addon.ingress_port)
configUrl="homeassistant://hassio/ingress/$selfSlug"

# Ingress proxy
mkdir -p /etc/nginx/http.d
cat <<EOF > /etc/nginx/http.d/ingress.conf
server {
    listen $ingressPort;
    allow 172.30.32.2;
    deny all;
    location / {
        proxy_pass http://localhost:$optProxyPort/;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Start nginx
nginx -c /etc/nginx/nginx.conf

bashio::log.info "Starting TeslaBle2Mqtt v$reportedVersion"

mkdir -p /data/config/key

btAdapter=""
if [ -n "$optBtAdapter" ] && [ "$optBtAdapter" != "null" ]; then
    btAdapter="--btAdapter=$optBtAdapter"
fi

# Start the proxy
/usr/local/bin/TeslaBleHttpProxy \
    --scanTimeout=$optScanTimeout \
    --logLevel=$optLogLevel \
    --keys=/data/config/key \
    --cacheMaxAge=$optCacheMaxAge \
    $btAdapter \
    --httpListenAddress=":$optProxyPort"
