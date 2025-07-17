## ---------- DEFAULT VARIABLES
variable "create_namespace" {
  description = "Create the namespace, if not exists"
  type        = bool
  default     = true
}

## ---------- INPUT VARIABLES
variable "chart_repository" {
  description = "Char repository address"
  type        = string
}

variable "chart_release_name" {
  description = "Chart release name"
  type        = string
}

variable "chart_name" {
  description = "Chart name"
  type        = string
}

variable "chart_version" {
  description = "Chart version"
  type        = string
}

variable "namespace" {
  description = "Namespace to deploy the chart"
  type        = string
}

variable "values" {
  description = "Values to set"
  type        = any
}
