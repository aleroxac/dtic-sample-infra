## ---------- DEAFULT VARIABLES
variable "create_user" {
  description = "Create an user"
  type        = bool
  default     = true
}

variable "create_user_group" {
  description = "Create an user group"
  type        = bool
  default     = true
}

variable "associate_user_to_group" {
  description = "Associate user to a group"
  type        = bool
  default     = true
}

variable "use_parameter_group" {
  description = "Create and associate a parameter group to the redis cluster"
  type        = bool
  default     = true
}

variable "use_subnet_group" {
  description = "Create and associate a subnet group to the redis cluster"
  type        = bool
  default     = true
}



## ---------- INPUT VARIABLES
## ----- user
variable "user_id" {
  description = "User ID"
  type        = string
  default     = null
}

variable "user_name" {
  description = "User name"
  type        = string
  default     = null
}

variable "user_password" {
  description = "User password"
  type        = string
  default     = null
}

variable "user_access_string" {
  description = "User access string"
  type        = string
  default     = null
}



## ----- group
variable "group_name" {
  description = "Group name"
  type        = string
  default     = null
}

variable "group_members" {
  description = "Group members"
  type        = set(string)
  default     = []
}



## ----- subnet-group
variable "subnet_group_name" {
  description = "Subnet group name"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = set(string)
  default     = null
}


## ----- parameter-group
variable "parameter_group_name" {
  description = "Parameter group name"
  type        = string
  default     = null
}



## ----- redis-cluster
variable "redis_cluster_name" {
  description = "Redis cluster name"
  type        = string
}

variable "redis_version" {
  description = "Redis version"
  type        = string
}

variable "redis_cluster_num_cache_nodes" {
  description = "Redis cluster size"
  type        = number
}

variable "redis_cluster_node_type" {
  description = "Redis cluster node type"
  type        = string
}

variable "redis_cluster_sg_ids" {
  description = "List of Security Group IDs to be used by redis cluster"
  type        = set(string)
}

variable "tags" {
  description = "Redis cluster tags"
  type        = map(string)
}
