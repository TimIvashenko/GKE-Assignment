// Configuration of the provider
provider "google" {
  credentials = file("${var.credentials_path}")
  project     = var.project
  region      = var.region
}
// internal IP allocation
resource "google_compute_address" "mongodb_node_ip" {
  count        = 3
  name         = "mongodb-node-ip-${count.index}"
  subnetwork   = google_compute_subnetwork.subnet_mongodb.name
  address_type = "INTERNAL"
  address      = "10.0.1.${count.index + 2}"
  region       = var.region
}
// Creation of the 3 Compute Engine instances for the MongoDB cluster using count in each zone, can be in one zone for it to be less expensive but one point of failure
resource "google_compute_instance" "mongo_node" {
  count        = 3
  name         = "mongodb-node${count.index + 1}"
  description  = "VM hosting tools for node ${count.index + 1} of mongodb"
  machine_type = "e2-medium"
  zone         = var.zones[count.index]

  labels = {
    env = "dev"
    app = "mongodb"
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 10 # default persistent disk, ssd if read/write speed is important
    }
  }
// Creation of my-vpc and private subnet mongodb-subnet
  network_interface {
    network    = var.network
    subnetwork = var.subnet
    network_ip = google_compute_address.mongodb_node_ip[count.index].address
  }

  metadata = {
    "ssh-keys" = "${var.ssh_user}:${file("${var.public_key_path}")}"
    "enable-oslogin" = "TRUE"
  }

  tags = ["allow-mongodb", "nodeapp"]

  depends_on = [
    google_compute_network.my_vpc,
    google_compute_subnetwork.subnet_mongodb
  ]
// startup script to configure mongodb instances and intiate a replica set
metadata_startup_script = file("/home/tim/Desktop/Home_Directory/testmongodb/terraform/script/setup_mongodb.sh")

}
