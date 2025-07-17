resource "aws_security_group" "this" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.sg_vpc_id

  ingress {
    from_port   = var.sg_ingress_from_port
    to_port     = var.sg_ingress_to_port
    protocol    = var.sg_ingress_protocol
    cidr_blocks = var.sg_ingress_cidr_blocks
  }

  egress {
    from_port   = var.sg_egress_from_port
    to_port     = var.sg_egress_to_port
    protocol    = var.sg_egress_protocol
    cidr_blocks = var.sg_egress_cidr_blocks
  }

  tags = merge(var.tags, {
    Name = var.sg_name
  })
}
