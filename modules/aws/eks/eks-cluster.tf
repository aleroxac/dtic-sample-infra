resource "aws_eks_cluster" "this" {
  name = var.cluster_name

  role_arn = var.cluster_role_arn
  version  = var.cluster_kubernetes_version

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = merge(var.tags, {
    Name = var.cluster_name
  })
}
