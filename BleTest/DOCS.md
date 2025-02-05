## Ble Test

## Multiple Bluetooth adapters

It is possible to specify which BT adapter to use by configuring the `Bluetooth adapter` option with its address.
You can find out adapter addresses by running command `sudo hciconfig` or `sudo bluetoothctl list` (Device must not be in use or it won't show). The address will be in the format of `xx:xx:xx:xx:xx:xx` (MAC address).
> NOTE:  
> If you have a Bluetooth version 4.x adapter there is a high chance it won't work!


## Configuration

**Name:** Bluetooth adapter  
**Description:**  
The Bluetooth adapter to use. If not specified, the first available adapter will be used. If set to `00:00:00:00:00:00` all available adapters will be shown.
