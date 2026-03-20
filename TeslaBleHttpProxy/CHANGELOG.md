# Changelog

All notable changes to this project will be documented in this file.

## [2.3.0] - 2026-03-19

- Update to upstream wimaha/TeslaBleHttpProxy version 2.3.0 (pinned to commit SHA for reproducibility)
- Add support for role-based key system (Owner and Charging Manager roles)
- Add `vehicle_data_cache_time` configuration option (default: 30 seconds)
- Switch from command-line flags to environment variable configuration
- Add automatic redirect from ingress root to /dashboard
- Deprecate `bt_adapter` and `raw_hci` options (kept for backward compatibility but no longer used)
- Improve security with role-based access control
- Update log level values to lowercase format (debug, info, warn, error, fatal)
- Update default `scan_timeout` from 1 to 5 seconds
- Update documentation to use Home Assistant ingress instructions

## [0.2.1] - 2025-04-14

- Reduce warnings when a command is expectedly canceled

## [0.2.0] - 2025-04-08

- Add option to use raw HCI mode
- **[WARNING]**: To use raw sockets, host networking was enabled for the addon. Please check if any service is running on the same port as the addon.

## [0.1.4] - 2025-02-25

- Add missing debug log when connection command is finished

## [0.1.3] - 2025-02-25

- Improve Bluetooth stability on linux

## [0.1.2] - 2025-02-19

- Fix deadlock on linux if bluetooth adapter was restarted during LE scan, again

## [0.1.1] - 2025-02-13

- Fix deadlock on linux if bluetooth adapter was restarted during LE scan
- Prevent canceled requests hanging until command fails
- Additional debug logging

## [0.1.0] - 2025-02-12

- Update proxy to use BlueZ instead of raw sockets
- Remove addon from host network
- Reduce priviledges of the addon since they are not necesary anymore
- Increase security with AppArmor 
- Add Bluetooth adapter configuration option
- Update documentation
- Remove `Full access` option as it is not needed anymore

## [0.0.6] - 2025-02-08

- Revert 0.0.5 as it was causing issues

## [0.0.5] - 2025-02-05

- Add configuration option to allow using specific Bluetooth adapter

## [0.0.4] - 2025-02-01

- Use `true` instead of `false` for `full_access` in FA version of the addon... 🤦

## [0.0.3] - 2025-02-01

- Report RSSI as null instead of huge negative number when no vehicle is detected

## [0.0.2] - 2025-01-30

- More leniant json body errors regarding unexpected api requests

## [0.0.1] - 2025-01-30

- Initial version, this addon is created as a stripped down TeslaBle2Mqtt addon.