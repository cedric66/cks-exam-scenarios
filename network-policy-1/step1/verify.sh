#!/bin/bash

res=$(kubectl get networkpolicy allow-specific-pods -n restricted)

if [[ -n "$res" ]]; then
  exit 0
else
  exit 1
fi
