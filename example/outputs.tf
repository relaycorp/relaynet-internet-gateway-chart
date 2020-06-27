output "mongodb_uri" {
  value = mongodbatlas_cluster.main.mongo_uri_with_options
}
