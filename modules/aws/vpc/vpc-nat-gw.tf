resource "aws_nat_gateway" "nat_gateways" {
  for_each = var.nat_gateways

  subnet_id     = each.value.subnet_id
  allocation_id = each.value.allocation_id

  tags = merge(var.tags, {
    Name = each.value.name
  })
}
