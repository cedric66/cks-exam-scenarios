#!/bin/bash

# Verify that the Pod is running as a non-root user
pod_status=$(kubectl get pod dark-illusion -n limited -o jsonpath='{.status.phase}')
run_as=$(kubectl get pod dark-illusion -n limited -o jsonpath='{.spec.containers[0].securityContext.runAsNonRoot}')

if [[ "$pod_status" == "Running" && "$run_as" == "true" ]]; then
  exit 0
else
  exit 1
fi

res=$(cat /opt/non-root/answer | grep "prime-ships")

if [[ -n "$res" ]]; then
  exit 0
else
  exit 1
fi