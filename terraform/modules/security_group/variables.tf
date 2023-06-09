variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "ingress_rules" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
}