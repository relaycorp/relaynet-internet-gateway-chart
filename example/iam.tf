resource "google_service_account" "main" {
  project    = var.gcp_project_id
  account_id = "${var.environment_name}-gateway"
}
