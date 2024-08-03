#!/bin/bash

res=$(kubectl logs secret-list -n secure-api | tail -3 | grep -E "secret1|secret2|secret3")

# Check if result exist
if $res; then
  exit 0
else
  exit 1
fi
