# GitLab Deployer

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
