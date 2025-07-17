## ---------- DEAFULT VARIABLES
variable "use_parameter_group" {
  description = "Create and associate a parameter group to the postgresql instance"
  type        = bool
  default     = true
}

variable "use_subnet_group" {
  description = "Create and associate a subnet group to the postgresql instance"
  type        = bool
  default     = true
}



## ---------- INPUT VARIABLES
variable "parameter_group_name" {
  description = "Parameter group name"
  type = string
  default = null
}

variable "parameter_group_family" {
  description = "Parameter group family"
  type = string
  default = null
}

variable "parameter_group_description" {
  description = "Parameter group name"
  type = string
  default = null
}





variable "subnet_group_name" {
  description = "Subnet group name"
  type = string
  default = null
}

variable "subnet_group_subnet_ids" {
  description = "Subnet group ids"
  type = set(string)
  default = []
}





variable "postgresql_instance_name" {
  description = "PostgreSQL instance name"
  type = string
}

variable "postgresql_instance_version" {
  description = "PostgreSQL version"
  type = string
}

variable "postgresql_instance_class" {
  description = "PostgreSQL instance class"
  type = string
}

variable "postgresql_instance_storage" {
  description = "PostgreSQL instance disk size"
  type = number
}

variable "postgresql_instance_max_allocated_storage" {
  description = "PostgreSQL instance max allocated storage"
  type = number
}

variable "postgresql_instance_storage_type" {
  description = "PostgreSQL instance storage type"
  type = string
}

variable "postgresql_instance_publicly_accessible" {
  description = "PostgreSQL instance publicly accessible"
  type = bool
}

variable "postgresql_instance_multi_az" {
  description = "PostgreSQL instance multi-az" 
  type = bool
}

variable "postgresql_instance_sg_ids" {
  description = "List of security group IDs to associate to the PostgreSQL instance"
  type = set(string)
}

variable "postgresql_instance_skip_final_snapshot" {
  description = "Skip PostgreSQL instance final snapshot"
  type = bool
}

variable "postgresql_instance_delete_automated_backups" {
  description = "Delete PostgreSQL instance automated backups"
  type = bool
}

variable "postgresql_instance_backup_retention_period" {
  description = "PostgreSQL instance backup retention period"
  type = string
}

variable "postgresql_instance_backup_window" {
  description = "PostgreSQL instance backup window"
  type = string
}

variable "postgresql_instance_maintenance_window" {
  description = "PostgreSQL instance maintenance window"
  type = string
}

variable "postgresql_instance_username" {
  description = "PostgreSQL instance username"
  type = string
}

variable "postgresql_instance_password" {
  description = "PostgreSQL instance password"
  type = string
}

variable "tags" {
  description = "RDS instance tags"
  type        = map(string)
}
