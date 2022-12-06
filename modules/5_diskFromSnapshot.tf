resource "google_compute_disk" "apigee-1-disk" {
  name     = "apigee-1-disk"
  type     = "pd-standard"
  zone     = "asia-southeast2-a"
  snapshot = "projects/${var.project}/global/snapshots/manual-16082022-apigee-training-1"
}

resource "google_compute_disk" "apigee-2-disk" {
  name     = "apigee-2-disk"
  type     = "pd-standard"
  zone     = "asia-southeast2-a"
  snapshot = "projects/${var.project}/global/snapshots/manual-16082022-apigee-training-2"
}
