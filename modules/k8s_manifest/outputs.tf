output "manifest" {
  description = "Kubernetes YAML manifest"
  value       = kubernetes_manifest.this.manifest
}
