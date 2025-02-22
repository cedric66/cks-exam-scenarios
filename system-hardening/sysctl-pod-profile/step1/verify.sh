#!/bin/bash
# Verification script for sysctl-pod-profile step1

# Verify kubelet sysctl whitelist configuration
if ! sudo grep -q 'allowedUnsafeSysctls: \["debug.iotrace"\]' /var/lib/kubelet/config.yaml; then
  echo "Kubelet not configured with debug.iotrace in allowedUnsafeSysctls"
  exit 1
fi

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

echo "Verification successful - all checks passed"
exit 0
