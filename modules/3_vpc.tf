resource "google_compute_network" "vpc" {
  name                    = "tf-gke-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet-1" {
  name                     = "tf-subnet-1"
  ip_cidr_range            = "192.168.1.0/24"
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
  secondary_ip_range {
    range_name    = "tf-gke-pods"
    ip_cidr_range = "172.16.0.0/21"
  }
  secondary_ip_range {
    range_name    = "tf-gke-service"
    ip_cidr_range = "172.16.8.0/25"
  }
}

resource "google_compute_global_address" "psa-1" {
  name          = "psa-1"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "192.168.2.0"
  prefix_length = 23
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "psa-1-attach" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.psa1.name]
}
resource "google_compute_network_peering_routes_config" "psa-1-route" {
  peering = google_service_networking_connection.psa-1.name
  network = google_compute_network.vpc.name

  import_custom_routes = true
  export_custom_routes = true
}
