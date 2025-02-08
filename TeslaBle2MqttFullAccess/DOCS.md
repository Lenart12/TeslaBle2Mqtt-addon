# Configuring TB2M

## Quick start guide

Install this addon and configure its settings according to their instructions and start the addon. When it is running open the web ui and follow the key-pairing instructions listed [here](https://github.com/wimaha/TeslaBleHttpProxy?tab=readme-ov-file#generate-key-for-vehicle). When you have successfuly added your keys restart the addon.

If you are having issues with bluetooth device not working, try the full access version of the addon.

## Multiple Bluetooth adapters

It is possible to specify which BT adapter to use by configuring the `Bluetooth adapter` option with its address.
You can find out adapter addresses by running command `sudo hciconfig` or `sudo bluetoothctl list` (Device must not be in use or it won't show). The address will be in the format of `xx:xx:xx:xx:xx:xx` (MAC address).
> NOTE:  
> If you have a Bluetooth version 4.x adapter there is a high chance it won't work!

## Configuration

**Name:** VINs  
**Description:**  
A list of VINs to scan for. At least one VIN is required, but multiple can be specified. The VINs must be in uppercase and 17 characters long.

**Name:** Scan timeout  
**Description:**  
The time in seconds to scan for BLE devices. The default is 1 second. If a value of 0 is provided, the scan will run as long as it can.

**Name:** Cache max age  
**Description:**  
The maximum age in seconds to cache data. The default is 60 seconds. Set to 0 to dissalow caching.

**Name:** Proxy port  
**Description:**  
The port on which the proxy will bind to. Default is 5667.

**Name:** Bluetooth adapter  
**Description:**  
The Bluetooth adapter to use. If not specified, the first available adapter will be used.

**Name:** Poll interval  
**Description**  
The time in seconds to poll the vehicle for data. The default is 90 seconds.

**Name:** Poll interval while charging  
**Description:**  
The time in seconds to poll the vehicle for data while charging. The default is 20 seconds.

**Name:** Max charging amps  
**Description:**  
The upper limit for Charging amps input sensor, can be configured from 5A-48A. The default is 16 A.

**Name:** MQTT host  
**Description:**  
The hostname or IP address of the MQTT broker.

**Name:** MQTT port  
**Description:**  
The port of the MQTT broker. The default is 1883.

**Name:** MQTT username  
**Description:**  
The username to authenticate with the MQTT broker.

**Name:** MQTT password  
**Description:**  
The password to authenticate with the MQTT broker.

**Name:** MQTT QoS  
**Description:**  
The quality of service level to use for MQTT messages. The default is 0.

**Name:** MQTT prefix  
**Description:**  
The prefix to use for MQTT topics. The default is `tb2m`. The prefix must only contain alphanumeric characters, dashes, and underscores.

**Name:** Discovery prefix  
**Description:**  
The prefix to use for Home Assistant MQTT discovery topics. The default is `homeassistant`.

**Name:** Log level  
**Description:**  
The log level to use. The default is `INFO`.
