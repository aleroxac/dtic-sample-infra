resource "aws_eip" "eips" {
  for_each = var.eips

  domain = each.value.domain

  tags = merge(var.tags, {
    Name = each.value.name
  })
}
