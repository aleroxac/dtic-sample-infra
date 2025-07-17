## ---------- INPUT VARIABLES
variable "bucket_name" {
  description = "Bucket name"
  type        = string
}

variable "tags" {
  description = "Bucket tags"
  type        = map(string)
}
