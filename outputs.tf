output "mongodb_instance_details" {
  value = { 
    for idx, instance in google_compute_instance.mongo_node : 
      instance.name => google_compute_address.mongodb_node_ip[idx].address 
  }
}

output "instance_tags" {
  value = { for instance in google_compute_instance.mongo_node : instance.name => instance.tags }
  description = "The tags of each MongoDB instance"
}
