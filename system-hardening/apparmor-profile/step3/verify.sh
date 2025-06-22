#!/bin/bash

PROFILE_PATH="/etc/apparmor.d/your_profile"

# Check if profile exists
if [ ! -f "$PROFILE_PATH" ]; then
  echo "AppArmor profile not found at $PROFILE_PATH"
  exit 1
fi

# Check for capability restrictions
if ! grep -q "deny capability," "$PROFILE_PATH"; then
  echo "Capability restrictions not found in AppArmor profile"
  exit 1
fi

# Check if specific capabilities are allowed (optional)
if grep -q "capability [^,]*," "$PROFILE_PATH"; then
  echo "Specific capabilities are allowed"
fi

echo "Capability restrictions are properly configured"
exit 0
