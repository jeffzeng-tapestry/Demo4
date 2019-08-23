variable "region" {
  description = "The region resources will be built in"
  type = "string"
}

variable "environment" {
  description = "The environment the resources will be deployed in"
  type = "string"
}

variable "role_arn" {
  description = "The role arn that is assumed to make changes"
  type = "string"
}

variable "project" {
  description = "Project Name"
  type = "string"
  default = "activedirectory"
}

variable "terraform_workspace" {
  description = "The workspace to refrence for state files"
  type        = "string"
}

variable "state_bucket_name" {
  description = "The bucket in which our state files are stored."
  type        = "string"
}

variable "state_key_vpc" {
  description = "The key name for the VPC root's state file."
  type        = "string"
}

variable "state_bucket_region" {
  description = "The region that contains the state bucket"
  type        = "string"
}

variable "ec2_key_name" {
  description = "Key name to use for EC2 instances"
  type = "string"
  default = "authentication-prod-key"
}

variable "ec2_iam_instance_profile" {
  description = "IAM Instance Profile to attach to EC2 instances"
  type = "string"
  default = "TEST_SSM_ROLE"
}

variable "subnet_usawipwcohdc01" {
  description = "Which subnet to launch usawipwcohdc01 in to"
  type = "string"
}

variable "subnet_usawipwglbdc01" {
  description = "Which subnet to launch usawipwglbdc01 in to"
  type = "string"
}

variable "subnet_usawipwglbdc02" {
  description = "Which subnet to launch usawipwglbdc02 in to"
  type = "string"
}

variable "kms_key_id" {
  description = "KMS key to encrypt EBS volumes with"
  type = "string"
}

variable "global_dc_1_name" {
  description = "Name of global DC 1"
  type = "string"
}

variable "global_dc_2_name" {
  description = "Name of global DC 2"
  type = "string"
}

variable "coach_dc_1_name" {
  description = "Name of coach DC 1"
  type = "string"
}