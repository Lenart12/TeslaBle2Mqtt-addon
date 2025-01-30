# Configuring TB2M

## Quick start guide

Install this addon and configure its settings according to their instructions and start the addon. When it is running open the web ui and follow the key-pairing instructions listed [here](https://github.com/wimaha/TeslaBleHttpProxy?tab=readme-ov-file#generate-key-for-vehicle). When you have successfuly added your keys restart the addon.

If you are having issues with bluetooth device not working, try the full access version of the addon.

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

**Name:** Log level  
**Description:**  
The log level to use. The default is `INFO`.
