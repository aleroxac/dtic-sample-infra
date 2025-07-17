## ---------- DEFAULT VARIABLES
variable "nodegroups_config" {
  description = "Node group config list"
  type        = map(any)
  default     = {}
}



## ---------- INPUT VARIABLES
## ----- eks-cluster
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_role_arn" {
  description = "EKS cluster IAM role ARN"
  type        = string
}

variable "cluster_kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}


## ----- global
variable "tags" {
  description = "EKS cluster and nodegroup tags"
  type        = map(string)
}

variable "subnet_ids" {
  description = "Subnet IDs to be used on EKS cluster and nodegroup"
  type        = set(string)
}


## ----- eks-node-group
variable "nodegroup_name" {
  description = "EKS node group name"
  type        = string
  default     = null
}

variable "nodegroup_role_arn" {
  description = "EKS node group IAM role ARN"
  type        = string
  default     = null
}

variable "nodegroup_instance_types" {
  description = "List of instance types to be used in the EKS node group"
  type        = set(string)
  default     = null
}

variable "nodegroup_scaling_config_desired_size" {
  description = "EKS node group desired size"
  type        = number
  default     = null
}

variable "nodegroup_scaling_config_min_size" {
  description = "EKS node group minimum size"
  type        = number
  default     = null
}

variable "nodegroup_scaling_config_max_size" {
  description = "EKS node group maximum size"
  type        = number
  default     = null
}

variable "nodegroup_update_config_max_unavailable" {
  description = "EKS node group max unavailable nodes"
  type        = number
  default     = null
}

variable "nodegroup_disk_size" {
  description = "EKS node group disk size"
  type        = number
  default     = null
}

variable "nodegroup_ami_type" {
  description = "EKS node group AMI Type"
  type        = string
  default     = null
}

variable "nodegroup_capacity_type" {
  description = "EKS node group capacity type"
  type        = string
  default     = null
}

variable "nodegroup_labels" {
  description = "EKS node group labels"
  type        = map(string)
  default     = null
}

variable "node_repair_config_enabled" {
  description = "EKS node group node repair config"
  type        = bool
  default     = null
}
