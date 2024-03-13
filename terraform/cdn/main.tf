provider "aws" {
  region = var.region
}

module "label" {
  source = "cloudposse/label/null"
  version = "0.25.0"

  namespace = var.namespace
  name      = var.name
  stage     = var.stage
  tags      = var.tags   
}

terraform {
  required_version = "~> 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
  backend "s3" {}
}

module "cdn" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.92.0"

  name                                    = var.cdn_name
  block_origin_public_access_enabled      = "${var.block_origin_public_access_enabled}"
  allow_ssl_requests_only                 = "${var.allow_ssl_requests_only}"
  cloudfront_access_log_create_bucket     = "${var.cloudfront_access_log_create_bucket}"
  custom_error_response                   = var.custom_error_response
  encryption_enabled                      = true
  error_document                          = var.index_document
  index_document                          = var.index_document
  log_expiration_days                     = var.log_expiration_days
  versioning_enabled                      = "${var.versioning_enabled}"
  log_glacier_transition_days             = var.log_glacier_transition_days
  log_standard_transition_days            = var.log_standard_transition_days
  log_versioning_enabled                  = "${var.log_versioning_enabled}"
  website_enabled                         = "${var.website_enabled}"
  s3_website_password_enabled             = "${var.s3_website_password_enabled}"
  context                                 = module.label.context

}

module "cloudwatch_logs" {
  source  = "cloudposse/cloudwatch-logs/aws"
  version = "0.6.8"

  name              = var.cwl_name
  retention_in_days = var.retention_in_days
  
 
  context = module.label.context
}







