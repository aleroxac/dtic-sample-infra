resource "aws_elasticache_parameter_group" "this" {
  name   = var.parameter_group_name
  family = split(".", "redis${var.redis_version}")[0]

  tags = merge(var.tags, {
    Name = var.parameter_group_name
  })
}
