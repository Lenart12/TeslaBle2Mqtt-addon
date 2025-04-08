#!/usr/bin/with-contenv bashio

# Read options from the configuration
optProxyPort="$(bashio::config 'proxy_port' '5667')" # Internal port for the proxy
optVins="$(bashio::config 'vins')"
optBtAdapter="$(bashio::config 'bt_adapter' 'hci0')"
optRawHci="$(bashio::config 'raw_hci' 'false')"
optProxyUrl="$(bashio::config 'proxy_url' 'internal')"
optScanTimeout="$(bashio::config 'scan_timeout' '1')"
optCacheMaxAge="$(bashio::config 'cache_max_age' '5')"
optPollInterval="$(bashio::config 'poll_interval' '90')"
optPollIntervalCharging="$(bashio::config 'poll_interval_charging' '20')"
optMaxChargingAmps="$(bashio::config 'max_charging_amps' '16')"
optMqttQos="$(bashio::config 'mqtt_qos' '0')"
optMqttPrefix="$(bashio::config 'mqtt_prefix' 'tb2m')"
optDiscoveryPrefix="$(bashio::config 'discovery_prefix' 'homeassistant')"
optLogLevel="$(bashio::config 'log_level' 'INFO')"

# MQTT configuration
if ! bashio::config.is_empty 'mqtt_host'; then
    optMqttHost="$(bashio::config 'mqtt_host')"
else
    optMqttHost=$(bashio::services 'mqtt' 'host')
fi
if ! bashio::config.is_empty 'mqtt_port'; then
    optMqttPort="$(bashio::config 'mqtt_port')"
else
    optMqttPort=$(bashio::services 'mqtt' 'port')
fi
if ! bashio::config.is_empty 'mqtt_user'; then
    optMqttUser="$(bashio::config 'mqtt_user')"
else
    optMqttUser=$(bashio::services 'mqtt' 'username')
fi
if ! bashio::config.is_empty 'mqtt_pass'; then
    optMqttPass="$(bashio::config 'mqtt_pass')"
else
    optMqttPass=$(bashio::services 'mqtt' 'password')
fi

function filter_logs() {
    local sed_expr=""
    while (( $# > 0 )); do
        pattern=$(echo "$1" | sed 's/[\/&]/\\&/g')
        replacement=$(echo "$2" | sed 's/[\/&]/\\&/g')
        # Match and preserve delimiters using capture groups
        sed_expr="${sed_expr}s/(\b|_|\W\[[;0-9]*m)${pattern}(\b|_)/\1${replacement}\2/g;"
        shift 2
    done

    # Must do line by line to avoid buffering (sed -u is not available in BusyBox)
    while IFS= read -r line || [[ -n "$line" ]]; do
        echo "$line" | sed -E "$sed_expr"
    done

    # sed -Eu "$sed_expr"
}

# Configuration for sensitive information filtering
function filter_sensitive() {
    local hidden_vins=""
    for v in $optVins; do
        # Keep [0:3] and [9:10] (model, year, manufacturer) and discard the rest
        anonVin="$(echo $v | sed -E 's/(.{4}).{5}(.{2}).{6}/\1\2/')"
        hidden_vins="$hidden_vins $v {VIN-$anonVin}"
    done

    filter_logs \
        "$optMqttHost" "{MQTT-HOST}" \
        "$optMqttPass" "{MQTT-PASS}" \
        $hidden_vins
}

# Addon information
selfRepo=$(bashio::addon.repository)
reportedVersion=$(bashio::addon.version)
selfSlug=$(bashio::addons "self" "addons.self.slug" '.slug')

# Ingress configuration
ingressPort=$(bashio::addon.ingress_port)
configUrl="homeassistant://hassio/ingress/$selfSlug"

if [ "$optProxyUrl" = "internal" ]; then
    # Internal proxy URL
    optProxyUrl="http://localhost:$optProxyPort"
    startTbhp="true"
else
    # Custom proxy URL
    if [[ ! $optProxyUrl =~ ^https?:// ]]; then
        bashio::log.fatal "Invalid proxy URL: $optProxyUrl"
        exit 1
    fi

    startTbhp="false"
fi

# Ingress proxy
mkdir -p /etc/nginx/http.d
cat <<EOF > /etc/nginx/http.d/ingress.conf
server {
    listen $ingressPort;
    allow 172.30.32.2;
    deny all;
    location / {
        proxy_pass $optProxyUrl;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

bashio::log.info "Starting TeslaBle2Mqtt addon v$reportedVersion"


# Set the color output for the logs
export CLICOLOR_FORCE=1

if [ "$startTbhp" = "true" ]; then
    mkdir -p /data/config/key

    if [ $optRawHci = "true" ]; then
        TeslaBleHttpProxyBin=/usr/local/bin/TeslaBleHttpProxy
        adapterInfo="using HCI"
    else
        TeslaBleHttpProxyBin=/usr/local/bin/TeslaBleHttpProxy-BlueZ
        adapterInfo="using BlueZ"
    fi

    if [ -n "$optBtAdapter" ] && [ "$optBtAdapter" != "null" ]; then
        btAdapter="--btAdapter=$optBtAdapter"
        adapterInfo="$adapterInfo ($optBtAdapter)"
    else
        btAdapter=""
        adapterInfo="$adapterInfo (default)"
    fi

    bashio::log.info "Starting internal TeslaBleHttpProxy on port $optProxyPort $adapterInfo"

    # Start the proxy in the background
    $TeslaBleHttpProxyBin \
        --scanTimeout=$optScanTimeout \
        --logLevel=$optLogLevel \
        --keys=/data/config/key \
        --cacheMaxAge=$optCacheMaxAge \
        $btAdapter \
        --httpListenAddress=":$optProxyPort" |& filter_sensitive &
    proxyPid=$!

    # Wait for the proxy to start
    timeout 5 bash -c "until nc -z localhost $optProxyPort; do sleep 0.2; done"
    proxyOk=$?
    if [ $proxyOk -ne 0 ]; then
        bashio::log.fatal "Failed to start proxy"
        exit 1
    fi
else
    # Use the external proxy URL
    bashio::log.info "Using external proxy URL: $optProxyUrl"
    proxyPid=""
fi

# Start nginx
nginx -c /etc/nginx/nginx.conf

# Convert the VINs to multiple -v options
vinOptions=""
for vin in $optVins; do
    vinOptions="$vinOptions --vin $vin"
done

# Start TeslaBle2Mqtt
bashio::log.info "Starting TeslaBle2Mqtt"
/usr/local/bin/TeslaBle2Mqtt \
    --proxy-host=$optProxyUrl \
    --poll-interval=$optPollInterval \
    --poll-interval-charging=$optPollIntervalCharging \
    --max-charging-amps=$optMaxChargingAmps \
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
    $vinOptions |& filter_sensitive &
tb2mPid=$!

# Wait for either process to exit
wait -n $proxyPid $tb2mPid
