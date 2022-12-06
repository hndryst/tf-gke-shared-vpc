resource "google_compute_instance" "apigee-1" {
  name         = "tf-apigee-1"
  machine_type = "e2-standard-2"
  tags         = ["edgeui", "node1"]
  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet-1.name
    network_ip = "192.168.1.2"
    access_config {} //give instance external ip
  }
  boot_disk {
    source = google_compute_disk.apigee-1-disk.name
  }
  service_account {
    email  = google_service_account.sa.email
    scopes = ["cloud-platform"]
  }
  scheduling {
    preemptible                 = true
    provisioning_model          = "SPOT"
    automatic_restart           = false
    instance_termination_action = "STOP"
  }
  metadata = {
    "enable-oslogin" = "TRUE"
  }
  metadata_startup_script = "/opt/apigee/apigee-service/bin/apigee-all start"
}

resource "google_compute_instance" "apigee-2" {
  name         = "tf-apigee-2"
  machine_type = "e2-standard-2"
  tags         = ["node2"]
  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet-1.name
    network_ip = "192.168.1.3"
  }
  boot_disk {
    source = google_compute_disk.apigee-2-disk.name
  }
  service_account {
    email  = google_service_account.sa.email
    scopes = ["cloud-platform"]
  }
  scheduling {
    preemptible                 = true
    provisioning_model          = "SPOT"
    automatic_restart           = false
    instance_termination_action = "STOP"
  }
  metadata = {
    "enable-oslogin" = "TRUE"
  }
  metadata_startup_script = "sleep 30 && /opt/apigee/apigee-service/bin/apigee-all start"
}
