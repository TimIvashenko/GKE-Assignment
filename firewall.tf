resource "google_compute_firewall" "ssh_firewall" {
  name    = "ssh-firewall"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-mongodb"]
}

resource "google_compute_firewall" "mongodb_firewall" {
  name    = "mongodb-firewall"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-mongodb"]
}

resource "google_compute_firewall" "nodeapp_firewall" {
  name    = "nodeapp-firewall"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["3000", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nodeapp"]
}
