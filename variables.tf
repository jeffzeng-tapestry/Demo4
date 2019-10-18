variable "region" {
  description = "The region resources will be built in"
  type        = "string"
}

variable "environment" {
  description = "The environment the resources will be deployed in"
  type        = "string"
}

variable "role_arn" {
  description = "The role arn that is assumed to make changes"
  type        = "string"
}

variable "project" {
  description = "Project Name"
  type        = "string"
  default     = "activedirectory"
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
  type        = "string"
  default     = "authentication-prod-key"
}

variable "ec2_iam_instance_profile" {
  description = "IAM Instance Profile to attach to EC2 instances"
  type        = "string"
  default     = "TEST_SSM_ROLE"
}

variable "subnet_usawipwcohdc01" {
  description = "Which subnet to launch usawipwcohdc01 in to"
  type        = "string"
}

variable "subnet_usawipwglbdc01" {
  description = "Which subnet to launch usawipwglbdc01 in to"
  type        = "string"
}

variable "subnet_usawipwglbdc02" {
  description = "Which subnet to launch usawipwglbdc02 in to"
  type        = "string"
}

variable "kms_key_id" {
  description = "KMS key to encrypt EBS volumes with"
  type        = "string"
}

variable "global_dc_1_name" {
  description = "Name of global DC 1"
  type        = "string"
}

variable "global_dc_2_name" {
  description = "Name of global DC 2"
  type        = "string"
}

variable "coach_dc_1_name" {
  description = "Name of coach DC 1"
  type        = "string"
}


variable "probe_instance_details" {
  description = "An object which holds the details for the Probe instance"
  type = object({
    name                 = string
    ami                  = string
    instance_type        = string
    key_name             = string
    iam_instance_profile = string
    az_letter            = string  # The last character of the Availability Zone (a,b,c)
  })
  default = {
    name                 = "CHANGEME"
    ami                  = "CHANGEME"
    instance_type        = "CHANGEME"
    key_name             = "CHANGEME"
    iam_instance_profile = "CHANGEME"
    az_letter            = "a"  # The last character of the Availability Zone (a,b,c)

  }
}
variable "probe_volumes" {
  type        = map(any)
  description = "A map of objects for additional volumes for the Probe instance (passed to TF-AWS-EC2-Module)"
  default     = {}
}

variable "tags" {
  description = "Tag settings for this project"
  type        = map
  default = {
    dr_tier              = "Bronze"
    cost_center          = "00000000"
    application_id       = ""
    project_name         = "activedirectory"
    app_partner          = "Active Directory"
    cpm_backup           = "non_prod_us_east_bronze_15"
    environment          = "sharedservices"
    cloud_custodian_tags = ""
    compliance           = ""
    brand                = "TPR"
    os                   = "win2012"
    tf_repo              = "TF-AWS-ActiveDirectory-Root"
  }
}

variable "dc_ami" {
  description = "AMI to use for Domain Controllers"
  type        = string
}