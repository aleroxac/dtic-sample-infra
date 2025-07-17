resource "aws_eks_node_group" "this" {
  for_each = var.nodegroups_config

  node_group_name = each.key
  cluster_name    = lookup(each.value, "cluster_name")
  node_role_arn   = lookup(each.value, "nodegroup_role_arn")
  subnet_ids      = lookup(each.value, "subnet_ids")
  instance_types  = lookup(each.value, "nodegroup_instance_types")
  disk_size       = lookup(each.value, "nodegroup_disk_size")
  ami_type        = lookup(each.value, "nodegroup_ami_type")
  capacity_type   = lookup(each.value, "nodegroup_capacity_type")
  labels          = lookup(each.value, "nodegroup_labels")

  node_repair_config {
    enabled = lookup(each.value, "node_repair_config_enabled") 
  }

  scaling_config {
    desired_size = lookup(each.value, "nodegroup_scaling_config_desired_size")
    min_size     = lookup(each.value, "nodegroup_scaling_config_min_size")
    max_size     = lookup(each.value, "nodegroup_scaling_config_max_size")
  }

  update_config {
    max_unavailable = lookup(each.value, "nodegroup_update_config_max_unavailable")
  }

  tags = merge(lookup(each.value, "tags", var.tags), {
    Name = each.key
  })

  depends_on = [
    aws_eks_cluster.this
  ]
}
