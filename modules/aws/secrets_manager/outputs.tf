output "secret-id" {
  description = "Secret ID"
  value       = aws_secretsmanager_secret.this.id
}
