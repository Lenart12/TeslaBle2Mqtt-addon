# Changelog

All notable changes to this project will be documented in this file.

## [0.3.7] - 2025-04-14

- Reduce warnings when a command is issued and polling is expectedly canceled
- Update Documentation

## [0.3.6] - 2025-04-11

- Fix log filtering if a sensitive value is set to empty string

## [0.3.5] - 2025-04-10

- Fix command line switch causing TB2M to not start

## [0.3.4] - 2025-04-10

- Add seperate poll interval for when the vehicle is disconnected (away).

## [0.3.3] - 2025-04-10

- Fast polling adjustments and bugfixes
- Change logging to only show logs from TB2M. Internal TBHP will only show warnings and errors,
  unless new `DEBUG_ALL` log level is set.

## [0.3.2] - 2025-04-10

- Add fast polling after vehicle discovery, wakes up or on command. By default it will poll faster
  for 2 minutes. This can be configured in the settings.

## [0.3.1] - 2025-04-08

- Allow configuring the Bluetooth adapter in raw hci mode

## [0.3.0] - 2025-04-08

- Add support for both BlueZ and raw sockets for Bluetooth connection
- **[WARNING]**: To use raw sockets, host networking was enabled for the addon. Please check if any service is running on the same port as the addon.

## [0.2.6] - 2025-04-08

- Add option to use external TeslaBleHttpProxy instance instead

## [0.2.5] - 2025-02-25

- Rework poll interval and timeout handling to show less warnings
- Add missing debug log when connection command is finished

## [0.2.4] - 2025-02-25

- Improve Bluetooth stability on linux

## [0.2.3] - 2025-02-25

- Handle Mqtt reconnections if connection is lost

## [0.2.2] - 2025-02-19

- Fix deadlock on linux if bluetooth adapter was restarted during LE scan, again

## [0.2.1] - 2025-02-13

- Fix deadlock on linux if bluetooth adapter was restarted during LE scan
- Prevent canceled requests hanging until command fails
- Additional debug logging

## [0.2.0] - 2025-02-12

- Update TeslaBleHttpProxy to use BlueZ instead of raw sockets
- Remove addon from host network
- Reduce priviledges of the addon since they are not necesary anymore
- Increase security with AppArmor 
- Add Bluetooth adapter configuration option
- Mqtt broker is now automatically configured if it is installed on the same instance
- Update documentation
- Remove `Full access` option as it is not needed anymore
- Add censoring of logs for sensitive data

## [0.1.0] - 2025-02-09

- Add `Time to charge limit` sensor

## [0.0.24] - 2025-02-09

- Fix crash on vehicle not found error ([#5](https://github.com/Lenart12/TeslaBle2Mqtt/issues/5))

## [0.0.23] - 2025-02-08

- Revert 0.0.20 as it was causing issues

## [0.0.22] - 2025-02-08

- Set Charging amps minimum value from 5A to 1A
- Add setting to set Charging amps max value from 5A-48A
- Handle discovery when HA restarts

## [0.0.21] - 2025-02-05

- Improve error handling
- Change which value gets used for battery level to match the one displayed by the app

## [0.0.20] - 2025-02-05

- Add configuration option to allow using specific Bluetooth adapter

## [0.0.19] - 2025-02-01

- Improve logs with color and prefix

## [0.0.18] - 2025-02-01

- Fix connection always getting treated as online

## [0.0.17] - 2025-02-01

- Fix crash caused by bad yaml configuration

## [0.0.16] - 2025-02-01

- Use `true` instead of `false` for `full_access` in FA version of the addon... 🤦

## [0.0.15] - 2025-02-01

- Do a few quick retries before marking vehicle as offline
- Show RSSI and address as unknown when vehicle is away 

## [0.0.14] - 2025-01-31

- Fix typo in configuration url

## [0.0.13] - 2025-01-31

- Fix charge cable connected showing always connected
- Always show error related sensors (Last error, clear error)
- Fix config url to redirect to correct homeassistant

## [0.0.12] - 2025-01-31

- More leniant json body errors regarding unexpected api requests
- Wait for proxy start before launching TeslaBle2Mqtt to not cause errors on boot

## [0.0.11] - 2025-01-30

- Temporary fix for configuration url not allowing TB2M device to show up in Mqtt devices

## [0.0.10] - 2025-01-30

- Allow setting cache max age for api responses (`Cache-Control` header)

## [0.0.9] - 2025-01-30

- Allow proxy port to be configured and expose its dashboard via HA Ingress panel.

## [0.0.8] - 2025-01-30

- Fix climate mode showing as `off`  instead of `unknown` after vehicle is asleep

## [0.0.7] - 2025-01-30

- Show uptime in hours instead, as duration was filling up the logbook

## [0.0.6] - 2025-01-30

- Show uptime as duration instead of seconds

## [0.0.5] - 2025-01-29

- Correctly report addon version in Mqtt

## [0.0.4] - 2025-01-29

- Add alternative full access addon for users that are experiencing problems with Bluetooth devices

## [0.0.3] - 2025-01-29

- Add configuration for poll interval and poll interval while charging
- Add changelog

## [0.0.2] - 2025-01-29

- Bump TeslaBleHttpProxy
    - Hotfix for adding new private key 
    - Fix constantly waking up the car


## [0.0.1] - 2025-01-29

- Initial version, this addon is created