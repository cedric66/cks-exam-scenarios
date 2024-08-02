#!/bin/bash

ALLOWED=$(kubectl exec test-pod-allowed -n restricted -- curl -s -o /dev/null -w "%{http_code}" my-app.restricted.svc.cluster.local)
DENIED=$(kubectl exec test-pod-denied -n restricted -- curl -s -o /dev/null -w "%{http_code}" my-app.restricted.svc.cluster.local)

if [ "$ALLOWED" -eq 200 ] && [ "$DENIED" -ne 200 ]; then
  exit 0
else
  exit 1
fi
