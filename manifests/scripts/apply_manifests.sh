#!/bin/bash

# Apply the Kubernetes manifests
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f hpa.yaml
kubectl apply -f ingress.yaml
kubectl apply -f secret.yaml
kubectl apply -f backendconfig.yaml

echo "All manifests have been applied."
