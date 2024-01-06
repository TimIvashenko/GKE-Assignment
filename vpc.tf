resource "google_compute_network" "my_vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_mongodb" {
  name          = "subnet-mongodb"
  network       = google_compute_network.my_vpc.name
  ip_cidr_range = "10.0.1.0/24"
  region        = "me-west1"
}

resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = google_compute_network.my_vpc.name
  region  = "me-west1"
}

resource "google_compute_address" "nat_ip" {
  name   = "nat-ip"
  region = "me-west1"
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "nat-gateway"
  router                             = google_compute_router.nat_router.name
  region                             = "me-west1"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat_ip.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnet_mongodb.self_link
    source_ip_ranges_to_nat = ["PRIMARY_IP_RANGES"]
  }

}
