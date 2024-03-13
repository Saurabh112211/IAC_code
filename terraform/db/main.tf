provider "aws" {
  region = var.region
}

terraform {
  required_version = "~> 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
  }
  backend "s3" {}
}
resource "random_password" "db_password" {
   length = 16
   special = true
   override_special = "!#$%&*()-_+={}[]<>:?" 
}

resource "aws_ssm_parameter" "password" {
  name    = "/${var.namespace}/rds/password"
  type    = "String"
  value   = random_password.db_password.result
  overwrite = true
  depends_on = [ random_password.db_password ]

}

module "rds_instance" {
  source               = "cloudposse/rds/aws"
  version              = "1.1.0"
  database_name        = var.database_name
  database_user        = var.database_user
  database_password    = random_password.db_password.result
  database_port        = var.database_port
  multi_az             = var.multi_az
  storage_type         = var.storage_type
  allocated_storage    = var.allocated_storage
  storage_encrypted    = var.storage_encrypted
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  publicly_accessible  = var.publicly_accessible
  vpc_id               = data.aws_vpc.vpc.id
  subnet_ids           = data.aws_subnets.public.ids
  apply_immediately    = var.apply_immediately
  allowed_cidr_blocks  = [data.aws_vpc.vpc.cidr_block]
  db_parameter_group   = var.db_parameter_group
  name                 = var.rds_id_element        

  depends_on = [random_password.db_password]
}