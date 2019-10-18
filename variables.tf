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

## tags
variable "dr_tier" {
  description = "Business Continuity - specify the disaster recovery tiers - bronze, silver, gold, platinum - engineering/design"
  type        = string
  default     = "Bronze"
}
variable "cost_center" {
  description = "Governance - specifify the cost center - 12345678, 99999999 - engineering/design or alfabet"
  type        = string
  default     = "00000000"
}
variable "application_id" {
  description = "IT Portfolio - Map to application ID in Alfabet - App-230; app-451 - alfabet"
  type        = string
  default     = ""
}
variable "project_name" {
  description = "IT Portfolio - Name of project/application - Found; APTOS; C360 - feed from alfabet"
  type        = string
  default     = "activedirectory"
}
variable "app_partner" {
  description = "Operations - Application partner/ distribution group - John Doe - feed from alfabet"
  type        = string
  default     = "Active Directory"
}
variable "cpm_backup" {
  description = "Operations - identify the method used for backup of this resource - policy1, policy2, policy3 - engineering/design"
  type        = string
  default     = "non_prod_us_east_bronze_15"
}
variable "cloud_custodian_tags" {
  description = "Operations - Define which cloud custodian policies apply to this resource - Autoparking, PCI, Tagging, Autoscaling - engineering/design"
  type        = string
  default     = ""
}
variable "compliance" {
  description = "Security+Governance - Is this resource subject to any compliance requirements? Select all that apply. - pci, sox, gdpr, pii, none - engineering/design"
  type        = string
  default     = ""
}
variable "brand" {
  description = "IT Portfolio - Identify which Brand this resource services - TPR, COH, KS, SW - feed from alfabet"
  type        = string
  default     = "TPR"
}
variable "os" {
  description = "Operations - Which OS is installed? - win2016; win2012,rhel7.0,azlinux - engineering/design"
  type        = string
  default     = "windows"
}
variable "tf_repo" {
  description = "Assigned to TFRepo tag (repo remote origin path)"
  type        = string
  default     = "tf-aws-activedirectory-root"
}

variable "dc_ami" {
  description = "AMI to use for Domain Controllers"
  type        = string
}