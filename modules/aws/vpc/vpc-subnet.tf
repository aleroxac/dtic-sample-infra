resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id            = each.value.vpc_id
  cidr_block        = cidrsubnet(each.value.vpc_cidr_block, 8, each.value.cidr_offset)
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = each.value.public ? true : null

  tags = merge(var.tags, {
    Name = "${each.value.name}-${each.value.public ? "public" : "private"}-${substr(each.value.availability_zone, -1, 1)}"
  })
}
