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
