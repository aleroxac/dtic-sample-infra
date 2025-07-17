output "redis_id" {
  description = "Redis ID"
  value       = aws_elasticache_cluster.this.id
}

output "redis_address" {
  description = "Redis address"
  value       = aws_elasticache_cluster.this.cluster_address
}

output "redis_port" {
  description = "Redis port"
  value       = aws_elasticache_cluster.this.port
}

output "redis_user" {
  description = "Redis username"
  value       = aws_elasticache_user.this[0].user_name
}
