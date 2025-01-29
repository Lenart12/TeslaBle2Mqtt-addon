# Tesla Ble to Mqtt [Full access]

Tesla BLE to Mqtt is a project that bridges Tesla Bluetooth Low Energy (BLE) data to an MQTT broker. This allows you to monitor and interact with your Tesla vehicle using MQTT from Home assistant.

For more information visit [here](https://github.com/Lenart12/TeslaBle2Mqtt)

# WARNING: Full access version
This is the full access version of the Tesla Ble to Mqtt add-on. It is the same as the regular version,
but with full hardware access inside the container. This means that the container can access Bluetooth
devices and other hardware on the host system. This is only intended for users who are having issues with
the regular version and need full hardware access. It is recommended to use the regular version if it works.

Common errors in the regular version are `"can't read hci socket: broken pipe"` or `"input channel closed: io: read/write on closed pipe"`.

Other than the full hardware access, this add-on is the same as the regular version. It is recommended to use
the regular version if it works for you, as it is more secure and has less potential for issues.
