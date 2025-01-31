# Changelog

All notable changes to this project will be documented in this file.

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