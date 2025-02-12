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

### Exposing TeslaBleHttpProxy
If you want to expose TeslaBleHttpProxy to external services (like `evcc`), you can configure the proxy port in `Configuration > Network > Show disabled ports` and then setting the port to an available value. The proxy dashboard will always be available via the Home Assistant Ingress panel, even if the port is not exposed.

### MQTT Settings
If you are using the Home Assistant with integrated MQTT broker (e.g. Mosquitto addon), you can leave broker settings empty. Otherwise, configure the MQTT settings to match your broker. Because the addon runs in a separate container, you may need to use the broker's IP address instead of `localhost`.
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

## Troubleshooting

### Bluetooth Issues
- Verify BlueZ is installed correctly
- Check [Home Assistant Bluetooth requirements](https://www.home-assistant.io/integrations/bluetooth/#requirements-for-linux-systems)

### Connection Problems
- Ensure the vehicle is within Bluetooth range
- Verify key pairing was successful
- Check MQTT broker is reachable from the addon
  - Use the broker's IP address instead of localhost
  - Verify MQTT credentials if authentication is enabled

## Support
- Submit an issue on the [GitHub repository](https://github.com/Lenart12/TeslaBle2Mqtt-addon/issues). Please include logs with `DEBUG` log level and configuration details.