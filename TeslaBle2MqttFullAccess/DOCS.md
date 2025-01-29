# Configuring TB2M

## Quick start guide

After installing this addon configure the settings according to their instructions and start the addon. After the addon is running open the web ui on port 5667. If you are running your home assistant behind a reverse proxy you might be unable to connect directly, so you need to connect to `http://{local-ha-ip}:5667/dashboard`. After this follow the key-pairing instructions listed [here](https://github.com/wimaha/TeslaBleHttpProxy?tab=readme-ov-file#generate-key-for-vehicle).

## Configuration

**Name:** VINs  
**Description:**  
A list of VINs to scan for. At least one VIN is required, but multiple can be specified. The VINs must be in uppercase and 17 characters long.

**Name:** Scan timeout  
**Description:**  
The time in seconds to scan for BLE devices. The default is 1 second. If a value of 0 is provided, the scan will run as long as it can.

**Name:** Poll interval
**Description**
The time in seconds to poll the vehicle for data. The default is 60 seconds.

**Name:** Poll interval while charging
**Description:**
The time in seconds to poll the vehicle for data while charging. The default is 20 seconds.

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
