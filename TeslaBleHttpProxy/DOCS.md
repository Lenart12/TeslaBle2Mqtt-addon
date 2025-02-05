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

**Name:** Cache max age  
**Description:**  
The maximum age in seconds to cache data. The default is 5 seconds. Set to 0 to disallow caching.

**Name:** Scan timeout  
**Description:**  
The time in seconds to scan for BLE devices. The default is 1 second. If a value of 0 is provided, the scan will run as long as it can.

**Name:** Proxy port  
**Description:**  
The port on which the proxy will bind to. Default is 5667.

**Name:** Bluetooth adapter  
**Description:**  
The Bluetooth adapter to use. If not specified, the first available adapter will be used.

**Name:** Log level  
**Description:**  
The log level to use. The default is `INFO`.
