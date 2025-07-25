resource "aws_secretsmanager_secret" "this" {
  name = var.secret_name

  tags = merge(var.tags, {
    Name = var.secret_name
  })
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_content

  depends_on = [
    aws_secretsmanager_secret.this
  ]
}
