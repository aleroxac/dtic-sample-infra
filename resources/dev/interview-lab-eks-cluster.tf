## ----- module: iam
module "eks-cluster-role" {
  source = "../../modules/aws/iam"

  role_name       = "${local.org_name}-eks-cluster-role-${local.team}-${local.product}-${local.service}-${var.environment}"
  policy_arn_list = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
  tags            = local.tags
  role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      },
    ]
  })

  depends_on = [
    module.vpc
  ]
}

module "eks-node-group-role" {
  source = "../../modules/aws/iam"

  role_name = "${local.org_name}-eks-node-group-role-${local.team}-${local.product}-${local.service}-${var.environment}"
  tags      = local.tags
  policy_arn_list = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ]
  role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  depends_on = [
    module.vpc
  ]
}



## ----- module: eks
module "eks-cluster" {
  source = "../../modules/aws/eks"

  cluster_name               = "${local.org_name}-eks-cluster-${local.team}-${local.product}-${local.service}-${var.environment}"
  cluster_role_arn           = module.eks-cluster-role.role-arn
  cluster_kubernetes_version = "1.33"
  subnet_ids                 = toset(data.aws_subnets.private_subnets.ids)
  tags                       = local.tags

  nodegroups_config = {
    "${local.org_name}-eks-node-group-${local.team}-${local.product}-${local.service}-${var.environment}" = {
      nodegroup_role_arn       = module.eks-node-group-role.role-arn
      nodegroup_ami_type       = "AL2_x86_64"
      nodegroup_capacity_type  = "ON_DEMAND"
      nodegroup_disk_size      = 20
      nodegroup_instance_types = ["t3.medium"]
      nodegroup_labels = {
        "environment"   = var.environment,
        "instance_type" = "t3.medium",
        "capacity_type" = "ON_DEMAND"
      }
      nodegroup_scaling_config_desired_size   = 1
      nodegroup_scaling_config_min_size       = 1
      nodegroup_scaling_config_max_size       = 3
      nodegroup_update_config_max_unavailable = 0
      node_repair_config_enabled              = true

    }
  }

  depends_on = [
    module.vpc,
    module.eks-cluster-role,
    module.eks-node-group-role,
  ]
}



## ----- module: helm
module "ingress-nginx-helmchart" {
  source = "../../modules/helm"

  chart_name         = "ingress-nginx"
  chart_repository   = "https://kubernetes.github.io/ingress-nginx"
  chart_release_name = "ingress-nginx"
  chart_version      = "4.11.3"
  namespace          = "ingress-nginx"
  create_namespace   = true
  values = [
    {
      name  = "fullnameOverride"
      value = "ingress-nginx"
    },

    {
      name  = "controller.ingressClassByName"
      value = true
    },
    {
      name  = "controller.ingressClassResource.name"
      value = "nginx"
    },
    {
      name  = "controller.ingressClassResource.enabled"
      value = true
    },
    {
      name  = "controller.ingressClassResource.default"
      value = true
    },
    {
      name  = "controller.ingressClassResource.controllerValue"
      value = "k8s.io/ingress-nginx"
    },

    {
      name  = "controller.ingressClass"
      value = "nginx"
    },

    {
      name  = "controller.service.enabled"
      value = true
    },
    {
      name  = "controller.service.external.enabled"
      value = true
    },
    {
      name  = "controller.service.internal.enabled"
      value = false
    }
  ]


  depends_on = [
    module.eks-cluster
  ]
}

module "cert-manager-helmchart" {
  source = "../../modules/helm"

  chart_name         = "cert-manager"
  chart_repository   = "https://charts.jetstack.io"
  chart_release_name = "cert-manager"
  chart_version      = "1.16.1"
  namespace          = "cert-manager"
  create_namespace   = true
  values = [
    {
      name  = "installCRDs"
      value = true
    }
  ]

  depends_on = [
    module.eks-cluster
  ]
}



## ----- module: k8s_manifest
module "cert_manager_cluster_issuer_prd_k8s_manifest" {
  source = "../../modules/k8s_manifest"

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name      = "letsencrypt-prd"
      namespace = "cert-manager"
    }
    spec = {
      acme = {
        email  = "acardoso.devops@gmail.com"
        server = "https://acme-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "letsencrypt-prd"
        }
        solvers = [
          {
            http01 = {
              ingress = {
                class = "nginx"
              }
            }
          }
        ]
      }
    }
  }

  depends_on = [
    module.ingress-nginx-helmchart
  ]
}

module "cert_manager_cluster_issuer_hml_k8s_manifest" {
  source = "../../modules/k8s_manifest"

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name      = "letsencrypt-hml"
      namespace = "cert-manager"
    }
    spec = {
      acme = {
        email  = "acardoso.devops@gmail.com"
        server = "https://acme-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "letsencrypt-hml"
        }
        solvers = [
          {
            http01 = {
              ingress = {
                class = "nginx"
              }
            }
          }
        ]
      }
    }
  }

  depends_on = [
    module.cert-manager-helmchart
  ]
}
