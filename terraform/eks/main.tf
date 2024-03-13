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

module "eks_cluster" {
  source = "cloudposse/eks-cluster/aws"
  version = "2.3.0"

  vpc_id                    = data.aws_vpc.vpc.id
  subnet_ids                = data.aws_subnets.private.ids
  apply_config_map_aws_auth = false
  kubernetes_version        = var.kubernetes_version
  oidc_provider_enabled     = true
  region                    = var.region
  map_additional_iam_users  = var.map_additional_iam_users

  context = module.label.context
}

module "eks_node_group" {
  source = "cloudposse/eks-node-group/aws"
  version     = "0.28.0"

  instance_types             = var.instance_types
  subnet_ids                 = data.aws_subnets.private.ids
  min_size                   = var.min_size
  max_size                   = var.max_size
  desired_size               = var.desired_size
  cluster_name               = module.eks_cluster.eks_cluster_id
  cluster_autoscaler_enabled = var.autoscaling_policies_enabled
  # Ensure the cluster is fully created before trying to add the node group
  module_depends_on          = module.eks_cluster.kubernetes_config_map_id

  context = module.label.context
}