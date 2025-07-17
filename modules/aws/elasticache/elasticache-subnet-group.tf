resource "aws_elasticache_subnet_group" "this" {
  name       = var.parameter_group_name
  subnet_ids = toset(var.subnet_ids)

  tags = merge(var.tags, {
    Name = var.parameter_group_name
  })
}
