## ----- module: random_password
module "redis_cluster_password" {
  source = "../../modules/random_password"

  length           = 50
  override_special = "!@#?%"

  lower   = true
  upper   = true
  numeric = true
  special = true

  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}



## ----- module: secrets_manager
module "redis_cluster_password_secret" {
  source = "../../modules/aws/secrets_manager"

  secret_name    = "${local.org_name}-first-redis-password-secret-${local.team}-${local.product}-${local.service}-${var.environment}"
  secret_content = module.redis_cluster_password.password
  tags           = local.tags

  depends_on = [
    module.redis_cluster_password
  ]
}



## ----- module: sg
module "redis_cluster_sg" {
  source = "../../modules/aws/sg"

  sg_name                = "${local.org_name}-sg-redis-${local.team}-${local.product}-${local.service}-${var.environment}"
  sg_description         = "Redis Security Group"
  sg_vpc_id              = module.vpc.vpc_id
  sg_ingress_from_port   = 6379
  sg_ingress_to_port     = 6379
  sg_ingress_protocol    = "tcp"
  sg_ingress_cidr_blocks = [for s in data.aws_subnet.private_subnets_ids : s.cidr_block]
  sg_egress_from_port    = 0
  sg_egress_to_port      = 0
  sg_egress_protocol     = "-1"
  sg_egress_cidr_blocks  = ["0.0.0.0/0"]
  tags                   = local.tags

  depends_on = [
    module.vpc
  ]
}



## ----- module: vpc
module "redis_cluster_private_nacl" {
  source = "../../modules/aws/vpc"

  nacls = {
    private-nacl = {
      vpc_id     = module.vpc.vpc_ids["main"]
      name       = "private-nacl"
      subnet_ids = [
        module.subnet.subnet_ids["private-1"],
        module.subnet.subnet_ids["private-2"],
        module.subnet.subnet_ids["private-3"]
      ]
      ingress = [
      {
        rule_no     = 100
        protocol    = "-1"
        rule_action = "allow"
        cidr_block  = "10.0.0.0/16"
        from_port   = 6379
        to_port     = 6379
      }]
      egress = [{
        rule_no     = 100
        protocol    = "-1"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
      }]
    }
  }

  tags = local.tags
}



## ----- module: elasticache
module "redis-cluster" {
  source = "../../modules/aws/elasticache"

  ## redis-cluster
  redis_cluster_name            = "${local.org_name}-elasticache-redis-cluster-${local.team}-${local.product}-${local.service}-${var.environment}"
  redis_version                 = "7.1"
  redis_cluster_node_type       = ""
  redis_cluster_num_cache_nodes = 1
  redis_cluster_sg_ids          = [module.redis_cluster_sg.sg-id]
  tags                          = local.tags

  ## user
  create_user        = true
  user_id            = "dev"
  user_name          = "dev"
  user_password      = module.redis_cluster_password.password
  user_access_string = "on ~* +@all"

  ## user-group
  create_user_group       = true
  associate_user_to_group = true
  group_name              = "lab"
  group_members           = ["dev"]

  ## subnet-group
  use_subnet_group  = true
  subnet_group_name = "${local.org_name}-redis-subnet-group-${local.team}-${local.product}-${local.service}-${var.environment}"
  subnet_ids        = toset(data.aws_subnets.private_subnets.ids)

  ## parameter-group
  use_parameter_group  = true
  parameter_group_name = "${local.org_name}-redis-parameter-group-${local.team}-${local.product}-${local.service}-${var.environment}"

  depends_on = [
    module.redis_cluster_sg,
    module.redis_cluster_password,
    module.redis_cluster_private_nacl
  ]
}
