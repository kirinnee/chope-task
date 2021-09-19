# GitLab Deployer

Deploys GitLab locally and on Digital Ocean (easily modified to include multi-cloud) on Kubernetes via Helm and
Terraform.


# Get Started
There are two routes: Allow Nix to handle all dependencies, or manually install dependencies.

## With Nix Pre-req
- [nix](https://nixos.org/download.html) > 2.3.15
- [direnv](https://direnv.net/) > 2.28.0
- [docker](https://www.docker.com/products/docker-desktop) > 20.10.8

## Without Nix Pre-req

System and Script usage
- [coretuils](https://www.gnu.org/software/coreutils/)
- [GNU grep](https://www.gnu.org/software/grep/)
- [jq](https://stedolan.github.io/jq/) > 1.6

Production
- [terraform](https://www.terraform.io/) > 1.0.0
- [kubectl](https://kubernetes.io/docs/tasks/tools/) > v1.22.1

Development
- [k3d](https://k3d.io/v4.4.8/) > 4.4.8
- [taskfile](https://taskfile.dev/#/) > 3.7.3
- [helm](https://helm.sh/) > 3.6.3
- [docker](https://www.docker.com/products/docker-desktop) > 20.10.8

Linting & Code Quality
- [terraform docs](https://github.com/terraform-docs/terraform-docs) > 0.15.0
- [pre-commit](https://pre-commit.com/) > 2.15.0
- [prettier](https://prettier.io/) > 2.4.0
- [shfmt](https://github.com/mvdan/sh) > 3.3.1
- [shellcheck](https://github.com/koalaman/shellcheck) > 0.7.2
- [nixpkgs-fmt](https://github.com/nix-community/nixpkgs-fmt) > 1.2.0


## Secrets And Credentials

Create the following **files** with credentials substituted:
- `.env`
    ```
    DIGITALOCEAN_TOKEN=<your Digital Ocean API Token
    ```

- `id.pub` - your SSH public key (for SSH-ing into machines)

# Local Development

- Configure Local Cluster in `k3d-default.yaml`



- Configure Local GitLab deployment in local.yaml


- Start Local Cluster
    ```
    task start
    ```
    and visit http://gitlab.127.0.0.1.nip.io

- Stop Local Cluster
    ```
    task stop
    ```

# Cloud Deployment
- Configure VM Cluster by checking the [Terraform Documentation](# Terraform Documentation)
- Configure GitLab helm values file in `terraform/gitlab-helm/resource.tf`, within `yamlencode`.

- Deploy the cluster:
    ```
    task apply
    ```

- Destroy the cluster
    ```
    task destroy
    ```


# Terraform Documentation
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gitlab"></a> [gitlab](#module\_gitlab) | ./terraform/gitlab-helm | n/a |
| <a name="module_k3s"></a> [k3s](#module\_k3s) | ./terraform/k3s | n/a |
| <a name="module_setup-k3s"></a> [setup-k3s](#module\_setup-k3s) | ./terraform/setup-k3s | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_node_type"></a> [agent\_node\_type](#input\_agent\_node\_type) | Droplet type for agents nodes | `string` | `"s-4vcpu-8gb"` | no |
| <a name="input_agent_nodes"></a> [agent\_nodes](#input\_agent\_nodes) | Number of agent nodes in the cluster | `number` | `1` | no |
| <a name="input_email"></a> [email](#input\_email) | Cert Manager issuer email | `string` | `"kirinnee97@gmail.com"` | no |
| <a name="input_master_node_type"></a> [master\_node\_type](#input\_master\_node\_type) | Droplet type the master node | `string` | `"s-4vcpu-8gb"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region to be deployed | `string` | `"sgp1"` | no |
| <a name="input_server_node_type"></a> [server\_node\_type](#input\_server\_node\_type) | Droplet type for server nodes | `string` | `"s-4vcpu-8gb"` | no |
| <a name="input_server_nodes"></a> [server\_nodes](#input\_server\_nodes) | Number of server nodes in the cluster. Must be even | `number` | `2` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gitlab_address"></a> [gitlab\_address](#output\_gitlab\_address) | n/a |
| <a name="output_initial_secret"></a> [initial\_secret](#output\_initial\_secret) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
