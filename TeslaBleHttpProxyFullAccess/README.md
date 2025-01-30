# Tesla Ble Http Proxy [Full access]

Tesla BLE Http Proxy exposes Tesla vehicle api over BLE. This addon is meant as a
standalone instance of the proxy and is not needed for TeslaBle2Mqtt addon.

This is only exposing the api for use with [evcc](https://evcc.io/) or other applications that make use of this api.

For more information visit [here](https://github.com/wimaha/TeslaBleHttpProxy)

# WARNING: Full access version
This is the full access version of the Tesla Ble Http Proxy add-on. It is the same as the regular version,
but with full hardware access inside the container. This means that the container can access Bluetooth
devices and other hardware on the host system. This is only intended for users who are having issues with
the regular version and need full hardware access. It is recommended to use the regular version if it works.

Common errors in the regular version are `"can't read hci socket: broken pipe"` or `"input channel closed: io: read/write on closed pipe"`.

Other than the full hardware access, this add-on is the same as the regular version. It is recommended to use
the regular version if it works for you, as it is more secure and has less potential for issues.
