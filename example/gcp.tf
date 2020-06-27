provider "google" {
  project = var.gcp_project_id
  region  = "europe-west2"
  zone    = "europe-west2-a"

  version = "~> 3.27"
}

resource "google_project" "main" {
  name       = var.gcp_project_id
  project_id = var.gcp_project_id
}
