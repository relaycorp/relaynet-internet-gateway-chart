output "object_storage_bucket" {
  value = google_storage_bucket.main.name
}
output "object_storage_access_key_id" {
  value = google_storage_hmac_key.main.access_id
}
output "object_storage_secret_key" {
  value = google_storage_hmac_key.main.secret
}

output "mongodb_user_name" {
  value = mongodbatlas_database_user.main.username
}
output "mongodb_user_password" {
  value = mongodbatlas_database_user.main.password
}

output "helm_values" {
  value = <<EOF
ingress:
  enabled: true
  apiVersion: networking.k8s.io/v1beta1
  annotations:
    kubernetes.io/ingress.global-static-ip-name: ${google_compute_global_address.managed_tls_cert.name}
    networking.gke.io/managed-certificates: gateway-${var.environment_name}
  enableTls: true

service:
  annotations:
    cloud.google.com/neg: '{"ingress": true}'
  type: NodePort

gatewayKeyId: MTM1NzkK
pohttpHost: ${var.pohttpHost}
cogrpcAddress: http://gw-test-relaynet-internet-gateway-pohttp.default.svc.cluster.local:8081

mongo:
  uri: ${lookup(mongodbatlas_cluster.main.connection_strings[0], "private_srv", mongodbatlas_cluster.main.mongo_uri)}/test_db

nats:
  serverUrl: nats://example-nats.default.svc.cluster.local:4222
  clusterId: example-stan

objectStore:
  endpoint: storage.googleapis.com
  bucket: ${google_storage_bucket.main.name}
  accessKeyId: ${google_storage_hmac_key.main.access_id}
  secretKey: ${google_storage_hmac_key.main.secret}

vault:
  serverUrl: http://vault-test.default.svc.cluster.local:8200
  token: letmein
EOF
}

output "gcp_global_ip" {
  value = google_compute_global_address.managed_tls_cert.address
}

output "gke_managed_certificate" {
  value = <<EOF
apiVersion: networking.gke.io/v1beta2
kind: ManagedCertificate
metadata:
  name: gateway-${var.environment_name}
spec:
  domains:
    - ${var.pohttpHost}
EOF
}
