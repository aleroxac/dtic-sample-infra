resource "aws_elasticache_user_group" "this" {
  count = var.create_user_group ? 1 : 0

  engine        = "redis"
  user_group_id = var.group_name
  user_ids      = tolist(concat(["default"], tolist(var.group_members)))

  tags = merge(var.tags, {
    Name = var.group_name
  })
}

resource "aws_elasticache_user_group_association" "this" {
  user_group_id = var.associate_user_to_group ? aws_elasticache_user_group.this[0].user_group_id : null
  user_id       = var.associate_user_to_group ? aws_elasticache_user.this[0].user_id : null

  depends_on = [local.user_group_dependencies]
}
