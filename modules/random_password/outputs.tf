output "password" {
  description = "Password content"
  value       = random_password.this.result
}
