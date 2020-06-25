# relaynet-internet-gateway-chart
Helm v3 chart for the Relaynet-Internet Gateway

## Development

Here's how to set up your local environment for development:

1. Install Vault:
   ```
   # Add HashiCorp's repo if you haven't done so yet
   helm repo add hashicorp https://helm.releases.hashicorp.com
   
   helm install vault-test hashicorp/vault \
       --set "server.dev.enabled=true" \
       --set "server.image.extraEnvironmentVars.VAULT_DEV_ROOT_TOKEN_ID=letmein"
   ```
1. Configure Vault:
   1. Enable the kv secret store
      ```
      kubectl exec -it vault-test-0 -- vault secrets enable -path=pong-keys kv-v2
      ```
1. Finally, deploy this chart and follow the post-install instructions:
   ```
   helm install \
     --set vault.host=vault-test.default.svc.cluster.local \
     --set vault.token=$VAULT_TOKEN \
     pong-test \
     .
   ```

1. Install NATS Streaming: https://github.com/nats-io/nats-streaming-operator
1. Install Mongo:
   ```
   helm repo add bitnami https://charts.bitnami.com/bitnami
   helm install mongo-test bitnami/mongodb
   ```
1. Install Minio:
   ```
   helm install \
       --name minio-test \
       --set accessKey=THE-KEY-ID,secretKey=letmeinpls \
       stable/minio
   ```
1. Install gw:
   ```
   helm install --values values.dev.yaml gw-test .
   ```
