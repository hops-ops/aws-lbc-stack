# aws-lbc-stack

A Crossplane Configuration package that installs the AWS Load Balancer Controller Helm chart with automated AWS Pod Identity for IAM permissions.

## Overview

`aws-lbc-stack` renders a Helm release for the AWS Load Balancer Controller and an AWS Pod Identity for automated IAM setup. The controller manages AWS Elastic Load Balancers for Kubernetes Ingress and Service resources.

## Features

- **Helm release**: Installs the AWS Load Balancer Controller chart with stable defaults
- **AWS Pod Identity**: Automatically provisions IAM role with the official ALB controller policy
- **Deletion ordering**: Usage resource ensures IAM cleanup happens after chart removal
- **Required clusterName**: The chart requires the EKS cluster name
- **Default namespace**: Installs to `kube-system` by default

## Prerequisites

- Crossplane installed in the cluster
- Crossplane providers:
  - `provider-helm` (>=v1.0.6)
- Crossplane configurations:
  - `aws-pod-identity` (>=v0.5.0)
- Crossplane functions:
  - `function-auto-ready` (>=v0.6.0)

## Quick Start

```yaml
apiVersion: pkg.crossplane.io/v1
kind: Configuration
metadata:
  name: aws-lbc-stack
spec:
  package: ghcr.io/hops-ops/aws-lbc-stack:latest
```

```yaml
apiVersion: aws.hops.ops.com.ai/v1alpha1
kind: LBCStack
metadata:
  name: aws-load-balancer-controller
  namespace: example-env
spec:
  clusterName: my-eks-cluster
  aws:
    region: us-east-1
```

## Configuration Options

| Field | Description | Default |
|-------|-------------|---------|
| `clusterName` | Name of the EKS cluster (required) | - |
| `aws.region` | AWS region (required) | - |
| `aws.vpcId` | VPC ID of the EKS cluster (required when pods can't reach IMDS — the EKS default with IMDSv2 hop-limit=1) | - |
| `aws.rolePrefix` | Prefix for the IAM role name | `""` |
| `aws.permissionsBoundaryArn` | ARN of IAM permissions boundary | `""` |
| `aws.tags` | Custom tags for AWS resources | `{}` |
| `namespace` | Namespace for the Helm release | `kube-system` |
| `name` | Helm release name | XR metadata.name |
| `helmProviderConfigRef` | Reference to Helm ProviderConfig | `{name: clusterName, kind: ProviderConfig}` |
| `awsProviderConfigRef` | Reference to AWS ProviderConfig | `{name: "default", kind: ProviderConfig}` |
| `labels` | Labels applied to all resources | `{hops.ops.com.ai/managed: "true"}` |
| `values` | Helm values merged with defaults | `{}` |
| `overrideAllValues` | Helm values replacing all defaults | `{}` |

## Default Helm Values

The chart is installed with these default values:

```yaml
fullnameOverride: aws-load-balancer-controller
nameOverride: aws-load-balancer-controller
clusterName: <from spec.clusterName>
```

## Development

```bash
make render
make validate
make test
```
