# Tesla Ble to Mqtt Documentation

## Overview
This addon allows you to connect to your Tesla vehicle via Bluetooth Low Energy (BLE) and publish the data to MQTT.

## Requirements
- Home Assistant with MQTT integration
- BlueZ installed on the host system
- Compatible Bluetooth adapter

## Quick Start Guide
1. Install the addon
2. Configure the settings (see Configuration section)
3. Start the addon
4. Open the web UI and follow the [key-pairing instructions](https://github.com/wimaha/TeslaBleHttpProxy?tab=readme-ov-file#generate-key-for-vehicle)
5. Restart the addon after successful key pairing

## Configuration notes

### Required Settings

- **VINs**: List of vehicle identification numbers (VINs) to connect to. You can find the VIN in the Tesla app or on the vehicle itself. Multiple VINs can be added to the list.
- If you have something *like* Mosquitto addon, you can leave all the MQTT settings empty. If you **don't have** integrated MQTT broker in Home Assistant, you need to configure the MQTT settings to match your broker. (See MQTT Settings)
- That's it! You can leave the rest of the settings as default.

### External TeslaBleHttpProxy
If you are using an external instance of TeslaBleHttpProxy, you can configure the proxy URL setting. It must be in the format `http(s)://<proxy_host>:<proxy_port>` (No trailing `/`!). The addon will use this URL to connect to the proxy instead of the internal one. This is useful if you want to run the proxy on a different machine or if you want to use a different version of the proxy. When using an external proxy, internal proxy will not be started and bluetooth settings will be ignored.

### Using TeslaBleHttpProxy
If you want to use TeslaBleHttpProxy with external services (like `evcc`), you can configure the proxy port in `Configuration > Proxy port` and then setting the port to an available value. The proxy dashboard will always be available via the Home Assistant Ingress panel, even if the port is changed.

### MQTT Settings
If you are using Home Assistant with an integrated MQTT broker (e.g. Mosquitto addon), you can leave broker settings empty. Otherwise, configure the MQTT settings to match your broker.
There is no need to configure the MQTT settings if you are using the default Home Assistant MQTT broker.

- **Host**: Address of your MQTT broker (default: HA MQTT service host)
- **Port**: MQTT broker port (default: HA MQTT service port)
- **Username**: MQTT username (default: HA addon user)
- **Password**: MQTT password (default: HA addon password)

### Bluetooth Adapter
- Leave empty to use system default adapter (hci0)
- Use `hciconfig` command to list available adapters, e.g. `hci1`
- If your wanted adapter shows up in the Bluetooth integration in Home Assistant, it should work with this addon
- There is no need to configure this setting if you are using the default adapter
- If you are having issues with the Bluetooth adapter, you can try enabling raw HCI mode (see below)

### Raw HCI
- If you are experiencing issues with the Bluetooth adapter, you can try enabling raw HCI mode.
  This mode allows the addon to communicate directly with the Bluetooth adapter using raw HCI commands.
  However note that this will take over the Bluetooth adapter and other applications (like Home Assistant) will not be able to use it.
  Also note that only the default adapter (hci0) is supported in this mode, so related settings will be ignored.
- This mode is not recommended for most users and should only be used as a last resort.

## Troubleshooting

### Bluetooth Issues
- Verify BlueZ is installed correctly
- Check [Home Assistant Bluetooth requirements](https://www.home-assistant.io/integrations/bluetooth/#requirements-for-linux-systems)
- Try using raw HCI mode if you are experiencing issues with the Bluetooth adapter

### Connection Problems
- Ensure the vehicle is within Bluetooth range
- Verify key pairing was successful
- Check MQTT broker is reachable from the addon
  - Verify MQTT credentials if authentication is enabled

## Support
- Submit an issue on the [GitHub repository](https://github.com/Lenart12/TeslaBle2Mqtt-addon/issues). Please include logs with `DEBUG` log level and configuration details.