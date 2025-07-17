resource "aws_db_instance" "this" {
  identifier               = var.postgresql_instance_name
  engine                   = "postgres"
  engine_version           = var.postgresql_instance_version
  instance_class           = var.postgresql_instance_class
  allocated_storage        = var.postgresql_instance_storage
  max_allocated_storage    = var.postgresql_instance_max_allocated_storage
  storage_type             = var.postgresql_instance_storage_type
  publicly_accessible      = var.postgresql_instance_publicly_accessible
  multi_az                 = var.postgresql_instance_multi_az
  vpc_security_group_ids   = var.postgresql_instance_sg_ids
  skip_final_snapshot      = var.postgresql_instance_skip_final_snapshot
  delete_automated_backups = var.postgresql_instance_delete_automated_backups
  backup_retention_period  = var.postgresql_instance_backup_retention_period
  backup_window            = var.postgresql_instance_backup_window
  maintenance_window       = var.postgresql_instance_maintenance_window
  username                 = var.postgresql_instance_username
  password                 = var.postgresql_instance_password


  parameter_group_name = var.use_parameter_group ? aws_db_parameter_group.this.name : null
  db_subnet_group_name = var.use_subnet_group ? aws_db_subnet_group.this.name : null

  tags = merge(var.tags, {
    Name = var.postgresql_instance_name
  })

  depends_on = [local.rds_instance_dependencies]
}

