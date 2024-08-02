#!/bin/bash

ALLOWED=$(kubectl exec test-pod-allowed -n jumpbox -- curl -s -o /dev/null -w "%{http_code}" commerce-frontend.restricted.svc.cluster.local)

if [ "$ALLOWED" -eq 200 ]; then
  exit 0
else
  exit 1
fi
