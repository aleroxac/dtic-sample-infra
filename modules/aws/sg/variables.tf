## ---------- INPUT VARIABLES
variable "sg_name" {
  description = "Security Group name"
  type = string
}

variable "sg_description" {
  description = "Security Group description"
  type = string
}

variable "sg_vpc_id" {
  description = "VPC ID to be used on Security Group"
  type = string
}

variable "sg_ingress_from_port" {
  description = "Security Group ingress port from"
  type = number
}

variable "sg_ingress_to_port" {
  description = "Security Group ingress port to"
  type = number
}

variable "sg_ingress_protocol" {
  description = "Security Group ingress protocol"
  type = string
}

variable "sg_ingress_cidr_blocks" {
  description = "Security Group ingress CIDR blocks"
  type = list(string)
}

variable "sg_egress_from_port" {
  description = "Security Group egress port from"
  type = number
}

variable "sg_egress_to_port" {
  description = "Security Group egress port to"
  type = number
}

variable "sg_egress_protocol" {
  description = "Security Group egress protocol"
  type = string
}

variable "sg_egress_cidr_blocks" {
  description = "Security Group egress CIDR blocks"
  type = list(string)
}

variable "tags" {
  description = "Security Group tags"
  type        = map(string)
}
