#!/usr/bin/with-contenv bashio

# Read options from the configuration
optBdAddr=$(bashio::config 'bd_addr' '00:00:00:00:00:00')

bashio::log.info "Starting Test"

bdAddr=""
if [ -n "$optBdAddr" ]; then
    bdAddr="--bdAddr=$optBdAddr"
fi

bashio::log.info "bdAddr: $bdAddr"

# Start the proxy
/usr/local/bin/test-ble \
    $bdAddr
