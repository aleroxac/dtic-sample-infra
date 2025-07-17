## ----- module: random_password
module "postgresql_user_password" {
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
module "postgresql_user_password_secret" {
  source = "../../modules/aws/secrets_manager"

  secret_name    = "${local.org_name}-postgresql-password-secret-${local.team}-${local.product}-${local.service}-${var.environment}"
  secret_content = module.postgresql_user_password.password
  tags           = local.tags

  depends_on = [
    module.postgresql_user_password
  ]
}



## ----- module: sg
module "postgresql_instance_sg" {
  source = "../../modules/aws/sg"

  sg_name                = "${local.org_name}-sg-postgresql-${local.team}-${local.product}-${local.service}-${var.environment}"
  sg_description         = "PostgreSQL Security Group"
  sg_vpc_id              = module.vpc.vpc_id
  sg_ingress_from_port   = 5432
  sg_ingress_to_port     = 5432
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
module "postgresql_instance_private_nacl" {
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
      ingress = [{
        rule_no     = 100
        protocol    = "-1"
        rule_action = "allow"
        cidr_block  = "10.0.0.0/16"
        from_port   = 5432
        to_port     = 5432
      }]
    }
  }

  tags = local.tags
}



## ----- module: rds
module "postgresql_instance" {
  source = "../../modules/aws/rds"

  ## ----- postgresql-instance
  postgresql_instance_name                     = "${local.org_name}-rds-postgresql-${local.team}-${local.product}-${local.service}-${var.environment}"
  postgresql_instance_version                  = "17"
  postgresql_instance_class                    = "db.t3.micro"
  postgresql_instance_storage                  = 20
  postgresql_instance_storage_type             = "gp2"
  postgresql_instance_max_allocated_storage    = 100
  postgresql_instance_skip_final_snapshot      = true
  postgresql_instance_delete_automated_backups = true
  postgresql_instance_multi_az                 = false
  postgresql_instance_publicly_accessible      = false
  postgresql_instance_sg_ids                   = [module.postgresql_instance_sg.sg-id]
  postgresql_instance_username                 = "lab"
  postgresql_instance_password                 = module.postgresql_user_password.password
  postgresql_instance_backup_retention_period  = 7
  postgresql_instance_backup_window            = "03:00-04:00"
  postgresql_instance_maintenance_window       = "sun:04:00-sun:05:00"
  tags                                         = local.tags

  ## parameter-group
  use_parameter_group         = true
  parameter_group_name        = "${local.org_name}-postgresql-pg-${local.team}-${local.product}-${local.service}-${var.environment}"
  parameter_group_family      = "postgres17"
  parameter_group_description = "Custom parameter group for PostgreSQL 17"

  ## subnet-group
  use_subnet_group        = true
  subnet_group_name       = "${local.org_name}-postgresql-subnet-group-${local.team}-${local.product}-${local.service}-${var.environment}"
  subnet_group_subnet_ids = toset(data.aws_subnets.private_subnets.ids)

  depends_on = [
    module.postgresql_user_password,
    module.postgresql_instance_sg,
    module.postgresql_instance_private_nacl
  ]
}
