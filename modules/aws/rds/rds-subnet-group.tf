resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_group_subnet_ids

  tags = merge(var.tags, {
    Name = var.subnet_group_name
  })
}
