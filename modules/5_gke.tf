resource "google_container_cluster" "dev" {
  name                     = "dev-cluster-1"
  location                 = "asia-southeast2-a"
  node_locations           = ["asia-southeast2-a", "asia-southeast2-b", "asia-southeast2-c"]
  remove_default_node_pool = true
  initial_node_count       = 1
  networking_mode          = "VPC_NATIVE"
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
  }
  ip_allocation_policy {
    cluster_secondary_range_name      = "loyalty-dev-pods"
    services_secondary_range_name     = "loyalty-dev-services"
    stack_type                        = "IPV4"
    master_authorized_networks_config = "192.168.0.0/28"
  }
  node_config {
    disk_type       = "pd-ssd"
    disk_size_gb    = 50
    service_account = "tf-compute-sa@datalabs-hs.iam.gserviceaccount.com"
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
  #   maintenance_policy {
  #     daily_maintenance_window {
  #       start_time = "03:00"
  #     }
  #   }
  #   maintenance_policy {
  #     recurring_window {
  #       start_time = "2019-01-01T09:00:00Z"
  #       end_time   = "2019-01-01T17:00:00Z"
  #       recurrence = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
  #     }
  #   }

  #   master_authorized_networks_config {
  #         cidr_blocks {
  #             cidr_block   = "123.456.789/32"
  #             display_name = "megacorp-1-nat1"
  #         }
  #         cidr_blocks {
  #             cidr_block   = "34.69.69.69/32"
  #             display_name = "megacorp-1-nat2"
  #         }
  #         cidr_blocks {
  #             cidr_block   = "123.456.333.333/32"
  #             display_name = "vpn-test"
  #         }

}
