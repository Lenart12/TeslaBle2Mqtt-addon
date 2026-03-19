# TeslaBleHttpProxy Documentation

## Overview
This addon allows you to connect to your Tesla vehicle via Bluetooth Low Energy (BLE) and interact with it using the TeslaBleHttpProxy service.

## Requirements
- BlueZ installed on the host system
- Compatible Bluetooth adapter

## Quick Start Guide
1. Install the addon
2. Configure the settings (see Configuration section)
3. Start the addon
4. Open the web UI and follow the [key-pairing instructions](https://github.com/wimaha/TeslaBleHttpProxy?tab=readme-ov-file#generate-key-for-vehicle)
5. Restart the addon after successful key pairing

## Configuration notes

### Proxy Port
- Default: 5667
- The internal port for the HTTP proxy
- Access the dashboard through Home Assistant ingress

### Scan Timeout
- Default: 5 seconds
- Time to scan for BLE devices
- Increase this value if the vehicle is sometimes not found

### Cache Max Age
- Default: 5 seconds
- HTTP Cache-Control header max-age value for body controller state responses
- Set to 0 to disable HTTP caching

### Vehicle Data Cache Time
- Default: 30 seconds
- Time to cache VehicleData endpoint responses in memory
- Each endpoint (charge_state, climate_state, etc.) is cached separately per VIN
- Reduces BLE connections for frequently requested data
- Set to 0 to disable in-memory caching

### Log Level
- Default: info
- Options: debug, info, warn, error, fatal
- Set to debug for detailed troubleshooting information

### Key Roles (Security)
The addon supports role-based key system:
- **Charging Manager** (Recommended): Limited access for charging management, works perfectly with evcc
- **Owner**: Full access to all vehicle functions (unlock, start, etc.)

Configure key roles in the dashboard at `http://YOUR_IP:8080/dashboard`

## Troubleshooting

### Bluetooth Issues
- Verify BlueZ is installed correctly
- Check [Home Assistant Bluetooth requirements](https://www.home-assistant.io/integrations/bluetooth/#requirements-for-linux-systems)
- Ensure D-Bus is accessible (addon mounts /var/run/dbus)

### Connection Problems
- Ensure the vehicle is within Bluetooth range
- Verify key pairing was successful in the dashboard
- Increase scan_timeout if the vehicle is sometimes not found
- Set log_level to debug for detailed troubleshooting

### Key Management
- Access the dashboard to manage key roles
- Charging Manager role is recommended for security
- Owner role required for non-charging functions (unlock, start, etc.)

## Support
- Submit an issue on the [GitHub repository](https://github.com/Lenart12/TeslaBle2Mqtt-addon/issues). Please include logs with `debug` log level and configuration details.