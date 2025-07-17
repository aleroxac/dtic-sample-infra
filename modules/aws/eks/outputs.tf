output "eks-cluster-id" {
  description = "EKS cluster ID"
  value       = aws_eks_cluster.this.id
}

output "eks-cluster-endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "eks-cluster-ca" {
  description = "EKS cluster Certificate Authority"
  value       = aws_eks_cluster.this.certificate_authority
}

output "eks-node-group-ids" {
  description = "EKS node group IDs"
  value       = aws_eks_node_group.this[*].id
}
