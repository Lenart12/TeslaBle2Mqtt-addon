#!/usr/bin/with-contenv bashio

# Read options from the configuration
optProxyPort="$(bashio::config 'proxy_port' '5667')" # Internal port for the proxy
optScanTimeout="$(bashio::config 'scan_timeout' '5')"
optLogLevel="$(bashio::config 'log_level' 'info')"
optCacheMaxAge="$(bashio::config 'cache_max_age' '5')"
optVehicleDataCacheTime="$(bashio::config 'vehicle_data_cache_time' '30')"
optExternalHostname="$(bashio::config 'external_hostname' 'homeassistant.local')"

# Deprecated options (kept for backward compatibility, but ignored)
if bashio::config.exists 'bt_adapter'; then
    bashio::log.warning "The 'bt_adapter' option is deprecated and no longer used. BlueZ handles adapter selection automatically."
fi
if bashio::config.exists 'raw_hci'; then
    bashio::log.warning "The 'raw_hci' option is deprecated and no longer used. The addon now uses BlueZ by default."
fi

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

    # Root shows dashboard
    location = / {
        proxy_pass http://localhost:$optProxyPort/dashboard;
        proxy_http_version 1.1;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;

        # Rewrite logs link to open in new tab with direct URL
        sub_filter '<a href="/logs"' '<a href="http://$optExternalHostname:$optProxyPort/logs" target="_blank"';
        sub_filter_once off;
        sub_filter_types text/html;
    }

    # All paths must be explicitly proxied
    location ~ ^/(dashboard|logs|api|static|gen_keys|remove_keys|add_key_to_vehicle|switch_role) {
        proxy_pass http://localhost:$optProxyPort\$request_uri;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Start nginx
nginx -c /etc/nginx/nginx.conf

# Create key directory
mkdir -p /data/config/key

bashio::log.info "Starting TeslaBleHttpProxy v$reportedVersion"

# Export environment variables for TeslaBleHttpProxy
export logLevel="$optLogLevel"
export scanTimeout="$optScanTimeout"
export cacheMaxAge="$optCacheMaxAge"
export vehicleDataCacheTime="$optVehicleDataCacheTime"
export httpListenAddress=":$optProxyPort"

# Change to config directory (contains key directory) for the proxy
cd /data/config

# Start the proxy
/usr/local/bin/TeslaBleHttpProxy
