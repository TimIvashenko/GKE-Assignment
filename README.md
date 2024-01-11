
# Constructing an autoscaling solution on GKE for a nodeapp.js application, and connecting it to a MongoDB Replica Set

The requirements for this project are as follows:

1. MongoDB replica set installed on 3 instances (not gke) - master, slave, arbiter

2. Nodeapp code should be updated to use the replica set instead of a single server

3. Nodeapp should be deployed on GKE with autoscaling and should scale from 2 to 10 pods.

4. Nodeapp should be exposed with an ingress with HTTP and HTTPS (a self-signed certificate can be used for HTTPS)

- Avoid using Marketplace

- Please use e2-medium instances for mongo and for gke.

- No need in "heavy" instances.

## MongoDB ReplicaSet using Terraform:

prerequisites : Terraform, Service Account in GCP with editor premission, Compute engine API. (ssh key to access instances)

commands are as follows : 

- ```terraform init``` 

- ```terraform plan```  
                        
- ```terraform apply```        

it creates three e2-medium instances, downloads MongoDB on all of them, and configures a Replica set with a Primary, Secondary and an Arbiter. Creates a VPC with firewall rules for the MongoDB instances, Private subnet which the instances are on.

## GKE Cluster :

prerequisites : GCP Account, Kubernetes engine API

in cloud shell create a cluster and deploy the app:

run scripts :

- ```./create_cluster.sh```
- ```./deploy_nginx_ingress.sh```
- ```./apply_maniefsts.sh```

## Nodeapp changes and Docker Image :

I edited the nodeapp.js to use the ReplicaSet instead of a single server,

built an image and pushed it to DockerHub, also can be used in Artifact Registry (GCR is soon to be deprecated)
