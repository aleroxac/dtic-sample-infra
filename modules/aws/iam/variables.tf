## ---------- INPUT VARIABLES
variable "role_name" {
  description = "Role name"
  type        = string
}

variable "role_policy" {
  description = "JSON encoded IAM policy"
  type        = string
}

variable "policy_arn_list" {
  description = "List of IAM policy ARNs to associate to the role"
  type        = list(string)
}

variable "tags" {
  description = "Role tags"
  type        = map(string)
}
