resource "google_compute_firewall" "ssh_firewall" { # ssh for testing
  name    = "ssh-firewall"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # my IP or VPN is more secure
  target_tags   = ["allow-mongodb", "nodeapp"]
}

resource "google_compute_firewall" "mongodb_firewall" { # mongodb port
  name    = "mongodb-firewall"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  source_ranges = ["0.0.0.0/0"] # instances IP more secure
  target_tags   = ["allow-mongodb", "nodeapp"]
}

resource "google_compute_firewall" "nodeapp_firewall" { # node app port
  name    = "nodeapp-firewall"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["3000", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"] # instances IP more secure
  target_tags   = ["allow-mongodb", "nodeapp"]
}

resource "google_compute_firewall" "all_pods_and_master_ipv4_cidrs" { # for pods and master for gke
  name    = "all-pods-and-master-ipv4-cidrs"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  direction     = "INGRESS"
  source_ranges = ["10.0.0.0/8", "172.16.2.0/28"] # range of ports
}

resource "google_compute_firewall" "allow_nginx_ingress" { # allow nginx ingress
  name    = "allow-nginx-ingress"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  direction   = "INGRESS"
  target_tags = ["nodeapp"]
}
