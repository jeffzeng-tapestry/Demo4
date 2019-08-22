# Terraform configuration 
terraform {
  required_version = ">= 0.12"

  # Using S3 for the backend state storage
  backend "s3" {
    region         = "us-east-1"
    bucket         = "techservices-us-east-1-sharedservices-state-bucket"
    key            = "templaterepo/terraform.tfstate" #The key name before the / needs to be changed. This needs to be a unique name
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

#This Data Source will read in the current AWS Region
data "aws_region" "current" {}

#This Data Source will use look in the remote state bucket for VPC information from a previosly built VPC
data "terraform_remote_state" "vpc" {
  backend   = "s3"
  workspace = var.terraform_workspace

  config = {
    region = var.region
    acl    = "private"
    bucket = var.state_bucket_name
    key    = var.state_key_vpc
  }
}

#This Data Source will find the latest version of the AWS Linux 2 AMI
data "aws_ami" "amazon-linux-2-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

############
# Resources
############

resource "aws_security_group" "ActiveDirectory" {
  
}

################
# Sample Module
################
#The below is a sample module being referneces from the Tapestry Github.


/*
module "vpc" { #Name of the module in the Root. If a module is being called multiple times in a root, it will need a unique name
  source = "git@github.com:tapestryinc/TF-AWS-VPC-Module.git?ref=v1.7" #Module source with a ref for the GitHub Version

  name                             = var.environment
  cidr                             = var.vpc_cidr
  azs                              = var.azs
  private_subnets                  = var.private_subnets
  public_subnets                   = var.public_subnets
  database_subnets                 = var.database_subnets
  create_database_subnet_group     = var.create_database_subnet_group
  privateexposed_subnets           = var.privateexposed_subnets
  enable_nat_gateway               = var.enable_nat_gateway
  enable_s3_endpoint               = var.enable_s3_endpoint
  enable_dhcp_options              = var.enable_dhcp_options
  dhcp_options_domain_name         = var.dhcp_options_domain_name
  dhcp_options_domain_name_servers = var.dhcp_options_domain_name_servers
  #enable_dns_hostnames            = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support

  #these tags are applied to all resources
  tags = {
    Environment = "${var.environment}"
  }
}
*/

