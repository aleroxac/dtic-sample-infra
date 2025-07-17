resource "aws_vpc" "vpcs" {
  for_each = var.vpcs

  cidr_block           = each.value.cidr_block
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support   = each.value.enable_dns_support

  tags = merge(var.tags, {
    Name = each.value.name
  })
}
