output "bucket-id" {
  description = "Bucket ID"
  value       = aws_s3_bucket.this.id
}

output "bucket-domain-name" {
  description = "Bucket Domain Name"
  value       = aws_s3_bucket.this.bucket_domain_name
}
