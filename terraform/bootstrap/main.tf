################################################
## defaults
################################################
terraform {
  required_version = "~> 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}
provider "aws" {
  region = var.region
  alias = "backend_state"
}


module "tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.2"
  environment = var.environment
  project     = var.project

  extra_tags = {
    Repo         = "github.com/sourcefuse/terraform-module-aws-bootstrap"
    MonoRepo     = "True"
    MonoRepoPath = "terraform/bootstrap"
  }
}

module "bootstrap" {
  source                   = "sourcefuse/arc-bootstrap/aws"
  version                  = "1.1.3"
  providers = {
    aws = aws.backend_state
  }
  bucket_name              = var.bucket_name
  dynamodb_name            = var.dynamodb_name
  

  tags = merge(module.tags.tags, tomap({
    Name         = var.bucket_name
    DynamoDBName = var.dynamodb_name
  }))

}