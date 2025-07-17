resource "aws_internet_gateway" "igws" {
  for_each = var.igws

  vpc_id = each.value.vpc_id

  tags = merge(var.tags, {
    Name = each.value.name
  })
}
