output "role-id" {
  description = "IAM role ID"
  value       = aws_iam_role.this.id
}

output "role-arn" {
  description = "IAM role ARN"
  value       = aws_iam_role.this.arn
}
