#!/bin/bash

# Add the nginx-stable Helm repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Deploy the NGINX Ingress controller
helm install nginx-ingress ingress-nginx/ingress-nginx

# Wait for a moment to ensure resources are created
echo "Waiting for NGINX Ingress controller resources to be created..."
sleep 30

# Verify the NGINX Ingress controller Deployment and Service
echo "Checking the deployment status of nginx-ingress-ingress-nginx-controller..."
kubectl get deployment nginx-ingress-ingress-nginx-controller

echo "Checking the service status of nginx-ingress-ingress-nginx-controller..."
kubectl get service nginx-ingress-ingress-nginx-controller
