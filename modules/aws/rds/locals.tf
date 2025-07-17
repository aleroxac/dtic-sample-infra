locals {
  rds_instance_dependencies = concat(
    var.use_parameter_group ? [aws_db_parameter_group.this] : [],
    var.use_subnet_group ? [aws_db_subnet_group.this] : []
  )
}
