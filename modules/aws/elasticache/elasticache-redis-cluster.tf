resource "aws_elasticache_cluster" "this" {
  cluster_id           = var.redis_cluster_name
  num_cache_nodes      = var.redis_cluster_num_cache_nodes
  node_type            = var.redis_cluster_node_type
  engine               = "redis"
  port                 = 6379
  engine_version       = var.redis_version
  security_group_ids   = var.redis_cluster_sg_ids

  parameter_group_name = var.use_parameter_group ? var.parameter_group_name : null
  subnet_group_name    = var.use_subnet_group ? var.subnet_group_name : null

  tags = merge(var.tags, {
    Name = var.redis_cluster_name
  })

  depends_on = [local.redis_cluster_dependencies]
}
