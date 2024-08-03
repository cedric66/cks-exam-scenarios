#!/bin/bash

# Create a namespace for testing
kubectl create namespace hardening

# Deploy a simple deployment, configmap, and secret for testing
kubectl apply -n hardening -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: landing-page
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: db-config
data:
  database_host: 172.170.0.1:6339
  debug_mode: 1
  log_level: verbose
---
apiVersion: v1
kind: Secret
metadata:
  name: secret1
type: Opaque
data:
  password: cGFzc3dvcmQ=
EOF

# Wait for the deployment to be ready
kubectl rollout status deployment/landing-page -n hardening

# Finish
sleep 3
touch /tmp/finished