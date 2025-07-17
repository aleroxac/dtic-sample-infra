resource "aws_route_table" "route_tables" {
  for_each = var.route_tables

  vpc_id = each.value.vpc_id

  tags = merge(var.tags, {
    Name = each.value.name
  })
}

resource "aws_route" "routes" {
  for_each = { for rt_key, rt in var.route_tables : rt_key => rt if length(rt.routes) > 0 }

  route_table_id         = aws_route_table.route_tables[each.key].id
  destination_cidr_block = each.value.routes[0].cidr_block

  gateway_id     = each.value.routes[0].gateway_id != null ? each.value.routes[0].gateway_id : null
  nat_gateway_id = each.value.routes[0].nat_gateway_id != null ? each.value.routes[0].nat_gateway_id : null
}

resource "aws_route_table_association" "associations" {
  for_each = var.route_tables

  subnet_id      = each.value.subnet_ids[0]
  route_table_id = aws_route_table.route_tables[each.key].id
}
