resource "google_service_account_iam_member" "iam" {
  for_each = toset([
    #"roles/logging.logWriter",
    #"roles/logging.viewer",
    #"roles/monitoring.metricWriter",
    "roles/container.nodeServiceAccount"
  ])
  role               = each.key
  service_account_id = google_service_account.sa.name
}
