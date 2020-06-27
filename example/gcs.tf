resource "google_storage_bucket" "main" {
  name          = "${var.environment_name}-gateway"
  location      = "EUROPE-WEST2"
  force_destroy = true
  project       = var.gcp_project_id

  bucket_policy_only = true
}

resource "google_storage_hmac_key" "main" {
  service_account_email = google_service_account.main.email
}
