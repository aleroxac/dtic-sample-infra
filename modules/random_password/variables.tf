## ---------- DEFAULT VARIABLES
variable "override_special" {
  description = "String with the special characters to override the default"
  type        = string
  default     = "!@#?%"
}

variable "length" {
  description = "Password length"
  type        = number
}

variable "lower" {
  description = "Require lower characters"
  type        = bool
}

variable "upper" {
  description = "Require upper characters"
  type        = bool
}

variable "numeric" {
  description = "Require numeric characters"
  type        = bool
}

variable "special" {
  description = "Require special characters"
  type        = bool
}

variable "min_lower" {
  description = "Minimum of lower characters"
  type        = number
}

variable "min_upper" {
  description = "Minimum of upper characters"
  type        = number
}

variable "min_numeric" {
  description = "Minimum of numeric characters"
  type        = number
}

variable "min_special" {
  description = "Minimum of special characters"
  type        = number
}
