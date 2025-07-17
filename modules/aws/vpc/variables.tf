## ---------- INPUT VARIABLES
## ----- global
variable "tags" {
  description = "Bucket tags"
  type        = map(string)
}



## ----- vpc
variable "vpcs" {
  description = "Map of VPCs to create. Each key is an identifier and the value is a configuration object."
  type = map(object({
    cidr_block           = string
    enable_dns_hostnames = bool
    enable_dns_support   = bool
    name                 = string
  }))
  default = {}
}



## ----- subnet
variable "subnets" {
  description = "Map of subnets to create. Each key is an identifier and the value is a configuration object."
  type = map(object({
    vpc_id            = string
    vpc_cidr_block    = string
    availability_zone = string
    cidr_offset       = number
    name              = string
    public            = bool
  }))
  default = {}
}



## ----- internet-gateway
variable "igws" {
  description = "Map of Internet Gateways to create. Each key is an identifier and the value is a configuration object."
  type = map(object({
    vpc_id = string
    name   = string
  }))
  default = {}
}



## ----- network-acl
variable "nacls" {
  description = "Map of Network ACLs to create. Each key is an identifier and the value is a configuration object."
  type = map(object({
    vpc_id     = string
    subnet_ids = list(string)
    name       = string
    ingress = list(object({
      rule_no     = number
      protocol    = string
      rule_action = string
      cidr_block  = string
      from_port   = number
      to_port     = number
    }))
    egress = list(object({
      rule_no     = number
      protocol    = string
      rule_action = string
      cidr_block  = string
      from_port   = number
      to_port     = number
    }))
  }))
  default = {}
}



## ----- route-table
variable "route_tables" {
  description = "Map of route tables to create. Each key is an identifier and the value is a configuration object."
  type = map(object({
    vpc_id = string
    name   = string
    routes = list(object({
      cidr_block     = string
      gateway_id     = optional(string)
      nat_gateway_id = optional(string)
    }))
    subnet_ids = list(string)
  }))
  default = {}
}



## ----- elastic-ip
variable "eips" {
  description = "Map of Elastic IPs to create. Each key is an identifier and the value is a configuration object."
  type = map(object({
    domain = optional(string, "vpc")
    name   = string
  }))
  default = {}
}



## ----- nat-gateway
variable "nat_gateways" {
  description = "Map of NAT Gateways to create. Each key is an identifier and the value is a configuration object."
  type = map(object({
    subnet_id     = string
    allocation_id = string
    name          = string
  }))
  default = {}
}
