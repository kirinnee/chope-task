variable "server_private_key" {
  type      = string
  sensitive = true
}

variable "agent_private_key" {
  type      = string
  sensitive = true
}

variable "master" {
  type = object({
    public_ip  = string
    private_ip = string
    user       = string
  })

}

variable "server_count" {
  type        = number
  description = "number of server nodes"
}

variable "agent_count" {
  type        = number
  description = "number of agent nodes"
}

variable "servers" {
  type = list(object({
    public_ip = string
    user      = string
  }))

  validation {
    condition     = length(var.servers) % 2 == 0
    error_message = "Servers + master must have an odd number of nodes."
  }
}

variable "agents" {
  type = list(object({
    public_ip = string
    user      = string
  }))
}
