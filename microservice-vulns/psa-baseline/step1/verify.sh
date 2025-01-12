#!/bin/bash

# Verify namespace exists
if ! kubectl get namespace audited &> /dev/null; then
  echo "Error: 'audited' namespace does not exist"
  exit 1
fi

# Verify PSA label is set to baseline
label=$(kubectl get namespace audited -o jsonpath='{.metadata.labels.pod-security\.kubernetes\.io/enforce}')
if [ "$label" != "baseline" ]; then
  echo "Error: PSA label not set to baseline"
  exit 1
fi

# Verify violating pod was not created
if kubectl get pod psa-violation -n audited &> /dev/null; then
  echo "Error: Violating pod was created successfully"
  exit 1
fi

echo "Verification successful - all checks passed"
exit 0