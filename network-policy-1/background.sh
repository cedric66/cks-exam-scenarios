#!/bin/bash

# Create a namespace for the scenario
kubectl create namespace restricted

# Create a deployment for the target application
kubectl apply -n restricted -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: commerce-frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: commerce-frontend
  template:
    metadata:
      labels:
        app: commerce-frontend
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
					- containerPort: 80        
EOF

# Wait for the deployment to be ready
kubectl rollout status deployment/commerce-frontend -n restricted
