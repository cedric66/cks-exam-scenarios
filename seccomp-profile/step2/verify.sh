#!/bin/bash

# Check if the Pod is running
if kubectl get pod seccomp-pod -n seccomp-test &>/dev/null; then
  # Check the seccomp status
  seccomp_status=$(kubectl exec -n seccomp-test seccomp-pod -- sh -c "cat /proc/self/status | grep Seccomp")
  if [[ "$seccomp_status" == *"2"* ]]; then
    # Attempt to run a restricted syscall
    syscall_test=$(kubectl exec -n seccomp-test seccomp-pod -- sh -c "unshare -p" 2>&1)
    if echo "$syscall_test" | grep -q "Operation not permitted"; then
      exit 0
    else
      exit 1
    fi
  else
    exit 1
  fi
else
  exit 1
fi
