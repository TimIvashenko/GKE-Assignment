#!/bin/bash

# Set compute region
gcloud config set compute/region me-west1

# Create Kubernetes cluster
gcloud container clusters create appnet-cluster \
    --region me-west1 \
    --num-nodes 1 \
    --node-locations me-west1-a,me-west1-b,me-west1-c \
    --disk-size 10GB \
    --network my-vpc \
    --subnetwork subnet-mongodb \
    --tags nodeapp,allow-mongodb
