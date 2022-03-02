provider "aws" {
  region = "us-east-1"
}

module "main" {
  source               = "../Module/RDS"
  db_name              = "versus_rds"
  sg_name              = "versus_rds_sg"
  mysql_sg_name        = "rds_mysql_versus_sg"
  from_port            = "3306"
  to_port              = "3306"
  protocol             = "tcp"
  from_port_egress     = "0"
  to_port_egress       = "0"
  protocol_egress      = "-1"
  cidr_blocks_egress   = ["0.0.0.0/0"]
  identifier           = "rds-versus"
  allocated_storage    = "10"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "versus_rds_db"
  db_username          = "admin"
  db_password          = var.db_password
  parameter_group_name = "default.mysql5.7"
  storage_type         = "gp2"
  backup_window        = "09:10-09:40"
  skip_final_snapshot  = true
  multi_az             = true
  self                 = true
}
