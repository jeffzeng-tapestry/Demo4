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
    region = var.state_bucket_region
    acl    = "private"
    bucket = var.state_bucket_name
    key    = var.state_key_vpc
  }
}

#This Data Source will find the latest version of the AWS Linux 2 AMI
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

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-${var.environment}-instance-sg"
    Owner       = var.project
    Environment = var.environment
  }
}

resource "aws_instance" "usawipwglbdc01" {
  ami = data.aws_ami.tpr_windows.id
  instance_type = "t2.large"
  vpc_security_group_ids = [aws_security_group.ActiveDirectory.id]
  key_name = var.ec2_key_name
  iam_instance_profile = var.ec2_iam_instance_profile
  subnet_id = var.subnet_usawipwglbdc01

  tags = {
    "Name" : var.global_dc_1_name
    "backup" : "default"
  }

  root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = var.kms_key_id
    volume_size = 70
    volume_type = "gp2"
  }

  ebs_block_device {
    delete_on_termination = true
    device_name = "xvdb"
    encrypted = true
    kms_key_id = var.kms_key_id
    volume_size = 100
    volume_type = "gp2"
  }
}

resource "aws_instance" "usawipwglbdc02" {
  ami = data.aws_ami.tpr_windows.id
  instance_type = "t2.large"
  vpc_security_group_ids = [aws_security_group.ActiveDirectory.id]
  key_name = var.ec2_key_name
  iam_instance_profile = var.ec2_iam_instance_profile
  subnet_id = var.subnet_usawipwglbdc02

  tags = {
    "Name" : var.global_dc_2_name
    "backup" : "default"
  }

  root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = var.kms_key_id
    volume_size = 70
    volume_type = "gp2"
  }

  ebs_block_device {
    delete_on_termination = true
    device_name = "xvdb"
    encrypted = true
    kms_key_id = var.kms_key_id
    volume_size = 100
    volume_type = "gp2"
  }
}

resource "aws_instance" "usawipwcohdc01" {
  ami = data.aws_ami.tpr_windows.id
  instance_type = "t2.large"
  vpc_security_group_ids = [aws_security_group.ActiveDirectory.id]
  key_name = var.ec2_key_name
  iam_instance_profile = var.ec2_iam_instance_profile
  subnet_id = var.subnet_usawipwcohdc01

  tags = {
    "Name" : var.coach_dc_1_name
    "backup" : "default"
  }

  root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = var.kms_key_id
    volume_size = 70
    volume_type = "gp2"
  }

  ebs_block_device {
    delete_on_termination = true
    device_name = "xvdb"
    encrypted = true
    kms_key_id = var.kms_key_id
    volume_size = 100
    volume_type = "gp2"
  }
}