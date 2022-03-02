##############################################################
# Data sources to get VPC and subnets details
##############################################################

data "aws_vpc" "eks_vpc" {
  filter {
    name   = "tag:Name"
    values = ["my-eks-vpc-stack-VPC"]
  }
}

data "aws_security_group" "eks_sg" {
  filter {
    name   = "tag:Name"
    values = ["eks-cluster-sg-21b-project-921617073"]
  }
}

data "aws_db_subnet_group" "subnet-group" {
  name = "subnet-group"
}

#######################################################################################################
# Creating a SG for rds db instance, with privat subnet in EKS VPC, Restrict access only to EKS cluster
#######################################################################################################

resource "aws_security_group" "rds_versus_sg" {
  name        = var.sg_name
  description = "SG for rds in EKS VPC"
  vpc_id      = data.aws_vpc.eks_vpc.id
  tags = {
    Name = var.mysql_sg_name
  }
}

#######################################################################################################
# Creating a SG rule for rds db instance for rds versus SG
#######################################################################################################

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = var.protocol
  cidr_blocks       = [data.aws_vpc.eks_vpc.cidr_block]
  security_group_id = aws_security_group.rds_versus_sg.id
}
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = var.from_port_egress
  to_port           = var.to_port_egress
  protocol          = var.protocol_egress
  security_group_id = aws_security_group.rds_versus_sg.id
  self              = var.self
}

##########################################################
# Creating a RDS db instance with multi az and auto backup
##########################################################

resource "aws_db_instance" "versus-rds-db" {
  identifier             = var.identifier
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.parameter_group_name
  storage_type           = var.storage_type
  skip_final_snapshot    = var.skip_final_snapshot
  db_subnet_group_name   = data.aws_db_subnet_group.subnet-group.id
  vpc_security_group_ids = [aws_security_group.rds_versus_sg.id]
  multi_az               = var.multi_az
  backup_window          = var.backup_window
  tags = {
    "Name" = "${var.db_name} - DB Server"
  }
}
