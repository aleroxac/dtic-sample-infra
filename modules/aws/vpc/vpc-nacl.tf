resource "aws_network_acl" "nacls" {
  for_each = var.nacls

  vpc_id = each.value.vpc_id

  tags = merge(var.tags, {
    Name = each.value.name
  })
}

resource "aws_network_acl_rule" "nacl_ingress" {
  for_each = { for nacl_key, nacl in var.nacls : nacl_key => nacl if length(nacl.ingress) > 0 }

  network_acl_id = aws_network_acl.nacls[each.key].id
  rule_number    = each.value.ingress[0].rule_no
  protocol       = each.value.ingress[0].protocol
  rule_action    = each.value.ingress[0].rule_action
  cidr_block     = each.value.ingress[0].cidr_block
  from_port      = each.value.ingress[0].from_port
  to_port        = each.value.ingress[0].to_port
  egress         = false
}

resource "aws_network_acl_rule" "nacl_egress" {
  for_each = { for nacl_key, nacl in var.nacls : nacl_key => nacl if length(nacl.egress) > 0 }

  network_acl_id = aws_network_acl.nacls[each.key].id
  rule_number    = each.value.egress[0].rule_no
  protocol       = each.value.egress[0].protocol
  rule_action    = each.value.egress[0].rule_action
  cidr_block     = each.value.egress[0].cidr_block
  from_port      = each.value.egress[0].from_port
  to_port        = each.value.egress[0].to_port
  egress         = true
}

resource "aws_network_acl_association" "nacl_association" {
  for_each = var.nacls

  network_acl_id = aws_network_acl.nacls[each.key].id
  subnet_id      = each.value.subnet_ids[0]
}