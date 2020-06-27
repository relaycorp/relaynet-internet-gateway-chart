resource "google_container_cluster" "primary" {
  name = "relaynet-gateway-example"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # Make cluster VPC-native (alias IP) so we can connect to GCP services
  ip_allocation_policy {}
}

resource "google_container_node_pool" "primary" {
  name       = "relaynet-gateway-example"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  node_count = 3

  node_config {
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_project_service" "logging" {
  project = var.gcp_project_id
  service = "logging.googleapis.com"
  disable_dependent_services = true
}
