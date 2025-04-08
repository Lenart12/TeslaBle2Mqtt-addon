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

## Troubleshooting

### Bluetooth Issues
- Verify BlueZ is installed correctly
- Check [Home Assistant Bluetooth requirements](https://www.home-assistant.io/integrations/bluetooth/#requirements-for-linux-systems)
- Try using raw HCI mode if you are experiencing issues with the Bluetooth adapter

### Connection Problems
- Ensure the vehicle is within Bluetooth range
- Verify key pairing was successful

## Support
- Submit an issue on the [GitHub repository](https://github.com/Lenart12/TeslaBle2Mqtt-addon/issues). Please include logs with `DEBUG` log level and configuration details.