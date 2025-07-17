locals {
  user_group_dependencies = concat(
    var.associate_user_to_group ? [aws_elasticache_user_group.this] : [],
    var.associate_user_to_group ? [aws_elasticache_user.this] : []
  )
}

locals {
  redis_cluster_dependencies = concat(
    var.use_parameter_group ? [aws_elasticache_parameter_group.this] : [],
    var.use_subnet_group ? [aws_elasticache_subnet_group.this] : []
  )
}
