output "postgresql-instance-id" {
  description = "PostgreSQL ID"
  value       = aws_db_instance.this.id
}

output "postgresql-address" {
  description = "PostgreSQL address"
  value       = aws_db_instance.this.address
}

output "postgresql-port" {
  description = "PostgreSQL port"
  value       = aws_db_instance.this.port
}

output "postgresql-user" {
  description = "PostgreSQL username"
  value       = aws_db_instance.this.username
}
