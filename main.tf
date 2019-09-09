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
  workspace = var.terraform_workspace

  config = {
    region = var.state_bucket_region
    acl    = "private"
    bucket = var.state_bucket_name
    key    = var.state_key_vpc
  }
}

#This Data Source will find the latest version of the Windows 2012 AMI from Amazon
data "aws_ami" "tpr_windows" {
  most_recent = true
  owners      = ["801119661308"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["Windows_Server-2012-R2_RTM-English-64Bit-Base-2019.06.12"]
  }
}

############
# Resources
############

resource "aws_security_group" "ActiveDirectory" {
  name        = "${var.project}-${var.environment}-instance-sg"
  description = "${var.project}-${var.environment}-instance-sg"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "Allow inbound from internal networks"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["172.16.0.0/12", "10.0.0.0/8", "156.146.0.0/16"]
  }

  tags = {
    Name        = "${var.project}-${var.environment}-instance-sg"
    Owner       = var.project
    Environment = var.environment
  }
}

module "global_dc_1" {
  source               = "git@github.com:tapestryinc/TF-AWS-EC2-Module.git?ref=v2.0.7"
  name                 = var.global_dc_1_name
  ami                  = data.aws_ami.tpr_windows.id
  instance_type        = "t2.large"
  key_name             = var.ec2_key_name
  subnet_id            = var.subnet_usawipwglbdc01
  os_type              = "windows"
  vpc_alias            = var.terraform_workspace
  security_group_ids   = [aws_security_group.ActiveDirectory.id]
  iam_instance_profile = var.ec2_iam_instance_profile
  addl_ebs_volumes = {
    "data-ebs" = {
      size        = 100
      type        = "gp2"
      device_name = "xvdb"
      encrypted   = true
      kms_key_id  = var.kms_key_id
      snapshot_id = null
    }
  }
}

module "global_dc_2" {
  source               = "git@github.com:tapestryinc/TF-AWS-EC2-Module.git?ref=v2.0.7"
  name                 = var.global_dc_2_name
  ami                  = data.aws_ami.tpr_windows.id
  instance_type        = "t2.large"
  key_name             = var.ec2_key_name
  subnet_id            = var.subnet_usawipwglbdc02
  os_type              = "windows"
  vpc_alias            = var.terraform_workspace
  security_group_ids   = [aws_security_group.ActiveDirectory.id]
  iam_instance_profile = var.ec2_iam_instance_profile
  addl_ebs_volumes = {
    "data-ebs" = {
      size        = 100
      type        = "gp2"
      device_name = "xvdb"
      encrypted   = true
      kms_key_id  = var.kms_key_id
      snapshot_id = null
    }
  }
}

module "coach_dc_1" {
  source               = "git@github.com:tapestryinc/TF-AWS-EC2-Module.git?ref=v2.0.7"
  name                 = var.coach_dc_1_name
  ami                  = data.aws_ami.tpr_windows.id
  instance_type        = "t2.large"
  key_name             = var.ec2_key_name
  subnet_id            = var.subnet_usawipwcohdc01
  os_type              = "windows"
  vpc_alias            = var.terraform_workspace
  security_group_ids   = [aws_security_group.ActiveDirectory.id]
  iam_instance_profile = var.ec2_iam_instance_profile
  addl_ebs_volumes = {
    "data-ebs" = {
      size        = 100
      type        = "gp2"
      device_name = "xvdb"
      encrypted   = true
      kms_key_id  = var.kms_key_id
      snapshot_id = null
    }
  }
}