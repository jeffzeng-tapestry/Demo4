# Terraform configuration 
terraform {
  required_version = ">= 0.12"

  # Using S3 for the backend state storage
  backend "s3" {
    region         = "us-east-1"
    bucket         = "techservices-us-east-1-sharedservices-state-bucket"
    key            = "activedirectory/terraform.tfstate"
    dynamodb_table = "techservices-sharedservices-state-table"
  }
}

#Provider configuration. Typically there will only be one provider config, unless working with multi account and / or multi region resources
provider "aws" {
  region = var.region

  assume_role {
    role_arn     = var.role_arn
    session_name = "terraform"
  }
}

###############
# Data Sources
###############

#This Data Source will use look in the remote state bucket for VPC information from a previously built VPC
data "terraform_remote_state" "vpc" {
  backend   = "s3"
  workspace = local.account_workspace

  config = {
    region = var.state_bucket_region
    acl    = "private"
    bucket = var.state_bucket_name
    key    = var.state_key_vpc
  }
}

locals {
  subnet_map            = {
    a = data.terraform_remote_state.vpc.outputs.private_subnets[0]
    b = data.terraform_remote_state.vpc.outputs.private_subnets[1]
    c = data.terraform_remote_state.vpc.outputs.private_subnets[2]
  }
  account_workspace = "${var.environment}-${var.region}"
}
