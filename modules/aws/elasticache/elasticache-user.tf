resource "aws_elasticache_user" "this" {
  count = var.create_user ? 1 : 0

  user_id       = var.user_id
  user_name     = var.user_name
  access_string = var.user_access_string
  engine        = "redis"

  tags = merge(var.tags, {
    Name = var.user_name
  })

  authentication_mode {
    type = "password"
    passwords = [
      var.user_password,
    ]
  }
}
