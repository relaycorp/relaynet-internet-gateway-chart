# Example deployment of the Relaynet-Internet gateway on Google Cloud Platform

This directory contains a Terraform module to deploy the Relaynet-Internet Gateway and its backing services to a production-ready environment on GCP.

Note that the primary objective here is to provide a working environment for this service, which can be used as a starting point for a real-world deployment where you may want to re-use any pre-existing instances of any backing services. Consequently, the gateway itself is configured with values that are safe in production, but you should check the corresponding documentation for the backing services to learn how to configure them in production.

Apart from the Kubernetes and GCP resources created by the chart, this Terraform module will create the following cloud resources:

- A GCP project.
- A GKE cluster.
- A corresponding GCP node pool.
- A GCP HTTP load balancer (managed by a Kubernetes ingress).
- A MongoDB Atlas project and cluster on GCP.

## Pre-requisites

1. Install the following dependencies: Git, Terraform, Helm 3, `kubectl` and the `gcloud` CLI.
1. Set your GCP credentials in a location supported by the GCP provider in Terraform, if you haven't already done so; for example:
  ```
   gcloud auth application-default login
  ```
1. Create the GCP project where you want to host the resources created by this module, unless you want to reuse an existing project.
1. Go to your project's [API library](https://console.cloud.google.com/apis/library/container.googleapis.com) and make sure the following APIs are enabled: Kubernetes.
1. Check out this directory if you haven't done so:
   ```
   git clone https://github.com/relaycorp/relaynet-internet-gateway-chart.git
   cd relaynet-internet-gateway-chart/example
   ```

## Install

1. Configure MongoDB Atlas:
   1. [Generate API keys](https://docs.atlas.mongodb.com/tutorial/manage-programmatic-access/index.html) (Organization Project Creator, Organization Member).
   1. Define them as environment variables:
      ```shell script
      export MONGODB_ATLAS_PUBLIC_KEY=<PUBLIC-KEY>
      export MONGODB_ATLAS_PRIVATE_KEY=<PRIVATE-KEY>
      ```
