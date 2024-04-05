# crea la base de datos
resource "aws_db_instance" "main" {
  allocated_storage    = var.allocated_storage_rds
  identifier           = var.identifier_rds
  db_name              = var.db_name_rds
  engine               = var.engine_rds
  engine_version       = var.engine_version_rds
  instance_class       = var.instance_claas_rds
  username             = var.username_rds
  password             = var.password_rds
  skip_final_snapshot  = true
  tags                 = var.common_tag
}