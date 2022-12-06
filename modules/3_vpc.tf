resource "google_compute_network" "vpc" {
  name                    = "tf-apigee-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet-1" {
  name                     = "tf-subnet-1"
  ip_cidr_range            = "192.168.1.0/24"
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}
