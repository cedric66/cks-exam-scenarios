#!/bin/bash

res=$(kubectl logs secret-list -n secure-api | tail -3 | grep -E "Failure|403")

# Check if result exist
if $res; then
  exit 0
else
  exit 1
fi
