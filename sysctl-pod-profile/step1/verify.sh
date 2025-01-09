#!/bin/bash
# Verification script for sysctl-pod-profile step1

# Check if pod exists
if ! kubectl get pod sysctl-pod &> /dev/null; then
  echo "Pod sysctl-pod not found"
  exit 1
fi

# Verify pod status
pod_status=$(kubectl get pod sysctl-pod -o jsonpath='{.status.phase}')
if [ "$pod_status" != "Running" ]; then
  echo "Pod is not in Running state"
  exit 1
fi

# Verify sysctl parameters
if ! kubectl exec sysctl-pod -- sysctl net.core.somaxconn | grep -q "1024"; then
  echo "net.core.somaxconn not set correctly"
  exit 1
fi

if ! kubectl exec sysctl-pod -- sysctl debug.iotrace | grep -q "1"; then
  echo "debug.iotrace not set correctly"
  exit 1
fi

echo "Verification successful - sysctl parameters are correctly configured"
exit 0
