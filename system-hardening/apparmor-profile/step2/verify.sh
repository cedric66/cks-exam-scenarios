#!/bin/bash

PROFILE_PATH="/etc/apparmor.d/restrict-network-profile"

# Check if profile exists
if [ ! -f "$PROFILE_PATH" ]; then
  echo "AppArmor profile not found at $PROFILE_PATH"
  exit 1
fi

# Check for network permissions
if ! grep -q "network inet," "$PROFILE_PATH" || ! grep -q "network inet6," "$PROFILE_PATH"; then
  echo "Network permissions not found in AppArmor profile"
  exit 1
fi

echo "Network permissions are properly configured"
exit 0
