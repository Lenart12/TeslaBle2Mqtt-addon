#!/usr/bin/env bash

# This script creates a full access addon for TeslaBle2Mqtt by copying the
# non-full access addon and patching the configuration with slug, name, description,
# and options.

# CD to the directory of this script
cd "$(dirname "$0")"

# Remove the full access addon if it already exists
rm -rf TeslaBle2MqttFullAccess

# Copy the non-full access addon
cp -r TeslaBle2Mqtt TeslaBle2MqttFullAccess

# Patch the version, name, description, and slug
sed -i 's/\(version: "\([^"]*\)\)"/\1-fa"/g' TeslaBle2MqttFullAccess/config.yaml
sed -i 's/\(name: "\([^"]*\)\)"/\1 [Full access]"/g' TeslaBle2MqttFullAccess/config.yaml
sed -i 's/\(description: "\([^"]*\)\)"/\1 [Full access version]"/g' TeslaBle2MqttFullAccess/config.yaml 
sed -i 's/\(slug: "\([^"]*\)\)"/\1-full-access"/g' TeslaBle2MqttFullAccess/config.yaml
# Add additional options
cat <<EOF >> TeslaBle2MqttFullAccess/config.yaml

full_access: false
EOF
# Patch README title to include full access information (# # Tesla Ble to Mqtt)
sed -i 's/# Tesla Ble to Mqtt/# Tesla Ble to Mqtt [Full access]/g' TeslaBle2MqttFullAccess/README.md
cat <<EOF >> TeslaBle2MqttFullAccess/README.md

# WARNING: Full access version
This is the full access version of the Tesla Ble to Mqtt add-on. It is the same as the regular version,
but with full hardware access inside the container. This means that the container can access Bluetooth
devices and other hardware on the host system. This is only intended for users who are having issues with
the regular version and need full hardware access. It is recommended to use the regular version if it works.

Common errors in the regular version are \`"can't read hci socket: broken pipe"\` or \`"input channel closed: io: read/write on closed pipe"\`.

Other than the full hardware access, this add-on is the same as the regular version. It is recommended to use
the regular version if it works for you, as it is more secure and has less potential for issues.
EOF


echo "Full access addon created in TeslaBle2MqttFullAccess"
