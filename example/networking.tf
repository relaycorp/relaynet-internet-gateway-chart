data "google_compute_network" "main" {
  name = "default"
}

resource "google_compute_network_peering" "mongodb_atlas" {
  name         = "mongodb-atlas-peering"
  network      = data.google_compute_network.main.self_link
  peer_network = "https://www.googleapis.com/compute/v1/projects/${mongodbatlas_network_peering.main.atlas_gcp_project_id}/global/networks/${mongodbatlas_network_peering.main.atlas_vpc_name}"
}
