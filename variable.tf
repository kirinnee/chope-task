variable "region" {
  description = "Region to be deployed"
  default     = "sgp1"
  type        = string
}

variable "server_nodes" {
  description = "Number of server nodes in the cluster. Must be even"
  default     = 2
  type        = number

  validation {
    condition     = var.server_nodes % 2 == 0
    error_message = "Servers + master must have an odd number of nodes."
  }
}

variable "agent_nodes" {
  description = "Number of agent nodes in the cluster"
  default     = 1
  type        = number
}

variable "master_node_type" {
  description = "Droplet type the master node"
  default     = "s-4vcpu-8gb"
  type        = string
}

variable "server_node_type" {
  description = "Droplet type for server nodes"
  default     = "s-4vcpu-8gb"
  type        = string
}


variable "agent_node_type" {
  description = "Droplet type for agents nodes"
  default     = "s-4vcpu-8gb"
  type        = string
}


variable "email" {
  default     = "kirinnee97@gmail.com"
  type        = string
  description = "Cert Manager issuer email"
}
