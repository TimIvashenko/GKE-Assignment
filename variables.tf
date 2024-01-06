
variable "public_key_path" {
  description = "Path to the public SSH key you want to bake into the instance."
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to the private SSH key, used to access the instance."
  default     = "~/.ssh/id_rsa"
}

variable "credentials_path" {
  description = "Path to the GCP account credentials."
  default     = "/home/tim/Desktop/GCP project/cluster-mongodb-terraform-ansible/mongodb-nodeapp-project-ad522e9be88a.json"
}

variable "project" {
  description = "Name of your GCP project."
  default     = "mongodb-nodeapp-project"
}

variable "region" {
  description = "Region."
  default     = "me-west1"
}

variable "zones" {
  description = "Zones."
  default     = ["me-west1-a", "me-west1-b", "me-west1-c"]
}

variable "ssh_user" {
  description = "SSH user name to connect to your instance."
  default     = "timivashenko"
}

variable "network" {
  description = "VPC name."
  type = string
  default = "my-vpc"
}

variable "subnet" {
  description = "Subnet where to host the cluster."
  type = string
  default = "subnet-mongodb"
}

variable "mongodb_port" {
  description = "Port used by the mongodb cluster."
  type = number
  default = "27017"
}