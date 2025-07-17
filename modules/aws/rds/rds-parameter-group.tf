resource "aws_db_parameter_group" "this" {
  name        = var.parameter_group_name
  family      = var.parameter_group_family
  description = var.parameter_group_description

  tags = merge(var.tags, {
    Name = var.parameter_group_name
  })
}
