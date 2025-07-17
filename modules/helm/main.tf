resource "helm_release" "this" {
  repository       = var.chart_repository
  name             = var.chart_release_name
  chart            = var.chart_name
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = var.create_namespace
  set              = var.values
}

