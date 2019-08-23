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
