resource "random_password" "this" {
  length           = var.length
  override_special = var.override_special

  lower   = var.lower
  upper   = var.upper
  numeric = var.numeric
  special = var.special

  min_lower   = var.min_lower
  min_upper   = var.min_upper
  min_numeric = var.min_numeric
  min_special = var.min_special
}
