resource "google_project_iam_member" "iam" {
  project = var.project
  for_each = toset([
    #"roles/logging.logWriter",
    #"roles/logging.viewer",
    #"roles/monitoring.metricWriter",
    "roles/container.nodeServiceAccount"
  ])
  role   = each.key
  member = "serviceAccount:${google_service_account.sa.email}"
}
