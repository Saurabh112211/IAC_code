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


module "vpc" {
  source                  = "cloudposse/vpc/aws"
  version                 = "2.2.0"
  ipv4_primary_cidr_block = "var.ipv4_primary_cidr_block"
  context                 = module.label.context
  
}
module "label" {
  source = "cloudposse/label/null"
  version = "0.25.0"

  namespace = var.namespace
  name      = var.name
  stage     = var.stage
  tags      = var.tags   
}
module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.0.4"

  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = [module.vpc.igw_id]
  ipv4_cidr_block      = [module.vpc.vpc_cidr_block]
  nat_gateway_enabled  = true
  nat_instance_enabled = false
  max_nats             = var.max_nats
  max_subnet_count     = var.max_subnet_count

  context = module.label.context
}