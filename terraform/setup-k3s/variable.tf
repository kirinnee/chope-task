variable "region" {
  description = "Region to be deployed"
  default = "sgp1"
  type = string
}

variable "server_nodes" {
  description = "Number of server nodes in the cluster. Must be odd"
  default = 1
  type = number
}

variable "agent_nodes" {
  description = "Number of agent nodes in the cluster"
  default = 1
  type = number
}

variable "server_node_type" {
  description = "Droplet type for server nodes"
  default = "s-4vcpu-8gb"
  type = string
}


variable "agent_node_type" {
  description = "Droplet type for agents nodes"
  default = "s-4vcpu-8gb"
  type = string
}



