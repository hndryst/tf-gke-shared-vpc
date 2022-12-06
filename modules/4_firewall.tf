resource "google_compute_firewall" "allow-internet-edgeui" {
  name    = "allow-edgeui-from-internet"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["9000"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["edgeui"]
}

resource "google_compute_firewall" "allow-node1-node2" {
  name    = "allow-node1-to-node2"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
  }
  source_tags = ["node1"]
  target_tags = ["node2"]
}

resource "google_compute_firewall" "allow-node2-node1" {
  name    = "allow-node2-to-node1"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
  }
  source_tags = ["node2"]
  target_tags = ["node1"]
}

resource "google_compute_firewall" "allow-iap-tf-apigee" {
  name    = "allow-iap-tf-apigee"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}
