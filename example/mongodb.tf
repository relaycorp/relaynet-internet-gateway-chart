provider "mongodbatlas" {
  version = "~> 0.6"
}

resource "mongodbatlas_project" "main" {
  name = var.environment_name
  org_id = var.mongodb_atlas_org_id
}

resource "mongodbatlas_cluster" "main" {
  project_id = mongodbatlas_project.main.id
  name = "main"
  num_shards = 1

  replication_factor = 3
  provider_backup_enabled = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version = "4.2"

  provider_name = "GCP"
  disk_size_gb = 10
  provider_instance_size_name = "M10"
  provider_region_name = "EUROPE_WEST_2"
}
