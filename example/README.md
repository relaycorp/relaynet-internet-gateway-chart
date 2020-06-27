# Example deployment of the Relaynet-Internet gateway on Google Cloud Platform

This directory contains a Terraform module to deploy the Relaynet-Internet Gateway and its backing services to a production-ready environment on GCP.

Note that the primary objective here is to provide a working environment for this service, which can be used as a starting point for a real-world deployment where you may want to re-use any pre-existing instances of any backing services. Consequently, the gateway itself is configured with values that are safe in production, but you should check the corresponding documentation for the backing services to learn how to configure them in production.

Apart from the Kubernetes and GCP resources created by the chart, this Terraform module will create the following GCP resources:

1. Configure MongoDB Atlas:
   1. [Generate API keys](https://docs.atlas.mongodb.com/tutorial/manage-programmatic-access/index.html) (Organization Project Creator, Organization Member).
   1. Define them as environment variables:
      ```shell script
      export MONGODB_ATLAS_PUBLIC_KEY=<PUBLIC-KEY>
      export MONGODB_ATLAS_PRIVATE_KEY=<PRIVATE-KEY>
      ```
