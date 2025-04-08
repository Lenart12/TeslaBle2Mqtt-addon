#!/usr/bin/with-contenv bashio

# Read options from the configuration
optProxyPort="$(bashio::config 'proxy_port' '5667')" # Internal port for the proxy
optBtAdapter="$(bashio::config 'bt_adapter' 'hci0')"
optRawHci="$(bashio::config 'raw_hci' 'false')"
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

mkdir -p /data/config/key

if [ $optRawHci = "true" ]; then
    TeslaBleHttpProxyBin=/usr/local/bin/TeslaBleHttpProxy
    adapterInfo="using HCI"
else
    TeslaBleHttpProxyBin=/usr/local/bin/TeslaBleHttpProxy-BlueZ
    adapterInfo="using BlueZ"
fi

btAdapter=""
if [ -n "$optBtAdapter" ] && [ "$optBtAdapter" != "null" ]; then
    btAdapter="--btAdapter=$optBtAdapter"
    adapterInfo="$adapterInfo ($optBtAdapter)"
fi

bashio::log.info "Starting TeslaBleHttpProxy v$reportedVersion $adapterInfo"

# Start the proxy
$TeslaBleHttpProxyBin \
    --scanTimeout=$optScanTimeout \
    --logLevel=$optLogLevel \
    --keys=/data/config/key \
    --cacheMaxAge=$optCacheMaxAge \
    $btAdapter \
    --httpListenAddress=":$optProxyPort"
