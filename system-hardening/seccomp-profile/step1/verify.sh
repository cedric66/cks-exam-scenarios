#!/bin/bash

# Check if the seccomp profile was successfully copied
if [ -e /var/lib/kubelet/seccomp/profiles/seccomp-audit.json ]; then
  # File exists, remove the copied file and exit with success status
  exit 0
else
  # File does not exist, exit with failure status
  exit 1
fi
