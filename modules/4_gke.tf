resource "google_container_cluster" "dev-cluster-1" {
  name                     = "dev-cluster-1"
  location                 = "asia-southeast2-a"
  node_locations           = ["asia-southeast2-b", "asia-southeast2-c"]
  remove_default_node_pool = true
  initial_node_count       = 1
  networking_mode          = "VPC_NATIVE"
  network                  = google_compute_network.vpc.name
  subnetwork               = google_compute_subnetwork.subnet-1.name
  ip_allocation_policy {
    cluster_secondary_range_name  = "tf-gke-pods"
    services_secondary_range_name = "tf-gke-services"
    stack_type                    = "IPV4"
  }
  node_config {
    disk_type       = "pd-ssd"
    disk_size_gb    = 50
    service_account = google_service_account.sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }
  release_channel {
    channel = "STABLE"
  }

  maintenance_policy {
    recurring_window {
      start_time = "2023-09-21T00:00:00Z"
      end_time   = "2023-09-21T04:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=MO,SA,SU"
    }
  }

  #   master_authorized_networks_config {
  #         cidr_blocks {
  #             cidr_block   = "123.456.789/32"
  #             display_name = "megacorp-1-nat1"
  #         }
  #         cidr_blocks {
  #             cidr_block   = "34.69.69.69/32"
  #             display_name = "megacorp-1-nat2"
  #         }

}

resource "google_container_node_pool" "dev-node-pool-1" {
  name       = "dev-node-pool-1"
  cluster    = google_container_cluster.dev-cluster-1.id
  node_count = 1

  node_config {
    machine_type    = "e2-custom-4-4096"
    disk_type       = "pd-ssd"
    disk_size_gb    = 50
    image_type      = "COS_CONTAINERD"
    service_account = google_service_account.sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  autoscaling {
    total_min_node_count = 1
    total_max_node_count = 3
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }

}
