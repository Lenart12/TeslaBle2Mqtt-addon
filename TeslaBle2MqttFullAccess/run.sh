#!/usr/bin/with-contenv bashio

# Check if port is already in use
optProxyPort=$(bashio::config 'proxy_port' '5667')

if netstat -tunl | grep -E ":$optProxyPort\b"; then
    bashio::log.fatal "Port $optProxyPort is already in use"
    exit 1
fi

# Read options from the configuration
optVins=$(bashio::config 'vins')
optBdAddr=$(bashio::config 'bd_addr', '')
optScanTimeout=$(bashio::config 'scan_timeout' '1')
optCacheMaxAge=$(bashio::config 'cache_max_age' '5')
optPollInterval=$(bashio::config 'poll_interval' '90')
optPollIntervalCharging=$(bashio::config 'poll_interval_charging' '20')
optMqttHost=$(bashio::config 'mqtt_host')
optMqttPort=$(bashio::config 'mqtt_port' '1883')
optMqttUser=$(bashio::config 'mqtt_user')
optMqttPass=$(bashio::config 'mqtt_pass')
optMqttQos=$(bashio::config 'mqtt_qos' '0')
optMqttPrefix=$(bashio::config 'mqtt_prefix' 'tb2m')
optDiscoveryPrefix=$(bashio::config 'discovery_prefix' 'homeassistant')
optLogLevel=$(bashio::config 'log_level' 'INFO')

# Addon information
selfRepo=$(bashio::addon.repository)
reportedVersion=$(bashio::addon.version)
selfSlug=$(bashio::addons "self" "addons.self.slug" '.slug')

# Ingress configuration
ingressUrl=$(bashio::addon.ingress_entry)
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

bashio::log.info "Starting TeslaBle2Mqtt v$reportedVersion"

bashio::log.info "VINs: $optVins"
bashio::log.info "Slug: $selfSlug"
bashio::log.info "Configuration url: $configUrl"
bashio::log.info "Ingress url: $(bashio::addon.ingress_url)"
bashio::log.info "Ingress ent: $(bashio::addon.ingress_entry)"
bashio::log.info "Repo: $(bashio::addon.repository)"
bashio::log.info "Hostname: $(bashio::addon.hostname)"

mkdir -p /data/config/key

# Set the color output for the logs
export CLICOLOR_FORCE=1

bdAddr=""
if [ -n "$optBdAddr" ]; then
    bdAddr="--bdAddr=$optBdAddr"
fi

# Start the proxy
/usr/local/bin/TeslaBleHttpProxy \
    --scanTimeout=$optScanTimeout \
    --logLevel=$optLogLevel \
    --keys=/data/config/key \
    --cacheMaxAge=$optCacheMaxAge \
    $bdAddr \
    --httpListenAddress=":$optProxyPort" &
proxyPid=$!

# Wait for the proxy to start
timeout 5 bash -c "until nc -z localhost $optProxyPort; do sleep 0.2; done"
proxyOk=$?
if [ $proxyOk -ne 0 ]; then
    bashio::log.fatal "Failed to start proxy"
    exit 1
fi

# Start nginx
nginx -c /etc/nginx/nginx.conf

# Convert the VINs to multiple -v options
vinOptions=""
for vin in $optVins; do
    vinOptions="$vinOptions --vin $vin"
done

# Start TeslaBle2Mqtt
/usr/local/bin/TeslaBle2Mqtt \
    --proxy-host=http://localhost:$optProxyPort \
    --poll-interval=$optPollInterval \
    --poll-interval-charging=$optPollIntervalCharging \
    --log-level=$optLogLevel \
    --mqtt-host=$optMqttHost \
    --mqtt-port=$optMqttPort \
    --mqtt-user=$optMqttUser \
    --mqtt-pass=$optMqttPass \
    --mqtt-qos=$optMqttQos \
    --mqtt-prefix=$optMqttPrefix \
    --discovery-prefix=$optDiscoveryPrefix \
    --reported-version=$reportedVersion \
    --reported-config-url=$configUrl \
    --force-ansi-color \
    --log-prefix="tb2m" \
    --reset-discovery \
    $vinOptions &
tb2mPid=$!

# Wait for either process to exit
wait -n $proxyPid $tb2mPid
