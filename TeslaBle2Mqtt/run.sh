#!/usr/bin/with-contenv bashio

# Start the proxy
bashio::log.info "Starting TeslaBle2Mqtt"

optVins=$(bashio::config 'vins')
scanTimeout=$(bashio::config 'scan_timeout' '1')
optMqttHost=$(bashio::config 'mqtt_host')
optMqttPort=$(bashio::config 'mqtt_port' '1883')
optMqttUser=$(bashio::config 'mqtt_user')
optMqttPass=$(bashio::config 'mqtt_pass')
optMqttQos=$(bashio::config 'mqtt_qos' '0')
optMqttPrefix=$(bashio::config 'mqtt_prefix' 'tb2m')
optDiscoveryPrefix=$(bashio::config 'discovery_prefix' 'homeassistant')
optLogLevel=$(bashio::config 'log_level' 'INFO')

mkdir -p /data/config/key

proxyBindAddress="0.0.0.0:5667"

/usr/local/bin/TeslaBleHttpProxy \
    --scanTimeout=$scanTimeout \
    --logLevel=$optLogLevel \
    --keys=/data/config/key \
    --httpListenAddress=$proxyBindAddress &
proxyPid=$!

# Convert the VINs to multiple -v options
vinOptions=""
for vin in $optVins; do
    vinOptions="$vinOptions --vin $vin"
done

# Start TeslaBle2Mqtt
/usr/local/bin/TeslaBle2Mqtt \
    --proxy-host=http://$proxyBindAddress \
    --log-level=$optLogLevel \
    --mqtt-host=$optMqttHost \
    --mqtt-port=$optMqttPort \
    --mqtt-user=$optMqttUser \
    --mqtt-pass=$optMqttPass \
    --mqtt-qos=$optMqttQos \
    --mqtt-prefix=$optMqttPrefix \
    --discovery-prefix=$optDiscoveryPrefix \
    $vinOptions &
tb2mPid=$!

# Wait for either process to exit
wait -n $proxyPid $tb2mPid
