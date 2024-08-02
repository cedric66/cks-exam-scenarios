#!/bin/bash

if kubectl get networkpolicy allow-specific-pods -n restricted; then
  exit 0
else
  exit 1
fi
