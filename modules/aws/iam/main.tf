resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.role_policy

  tags = merge(var.tags, {
    Name = var.role_name
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.policy_arn_list)

  policy_arn = each.value
  role       = aws_iam_role.this.name

  depends_on = [
    aws_iam_role.this
  ]
}
