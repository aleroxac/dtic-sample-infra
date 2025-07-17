## ---------- INPUT VARIABLES
variable "secret_name" {
  description = "Secret name"
  type        = string
}

variable "secret_content" {
  description = "Secret content"
  type        = string
}

variable "tags" {
  description = "Secret Tags"
  type        = map(string)
}
