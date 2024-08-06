#!/bin/bash

# Check if the seccomp profile exists on the node
if [ -f /var/lib/kubelet/seccomp/seccomp-profile.json ]; then
  exit 0
else
  exit 1
fi
