#!/bin/bash

# Copy the seccomp profile from the node to the local machine
scp node01:/var/lib/kubelet/seccomp/syscall-restrict.json /tmp/syscall-restrict.json 2>/dev/null

# Check if the seccomp profile was successfully copied
if [ -e /tmp/syscall-restrict.json ]; then
  # File exists, remove the copied file and exit with success status
  rm /tmp/syscall-restrict.json
  exit 0
else
  # File does not exist, exit with failure status
  exit 1
fi
