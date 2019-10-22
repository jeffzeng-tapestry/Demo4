region = "ap-southeast-1"

role_arn = "arn:aws:iam::018907257838:role/techservices-terraform-role"

environment = "sharedservices"

terraform_workspace = "sharedservices-ap-southeast-1"

state_bucket_name = "techservices-us-east-1-sharedservices-state-bucket"

state_key_vpc = "vpc/terraform.tfstate"

state_bucket_region = "us-east-1"

subnet_usawipwcohdc01 = "subnet-028ae003cd573bc1c"

subnet_usawipwglbdc01 = "subnet-0abd5da1a44c64f81"

subnet_usawipwglbdc02 = "subnet-085ba6757eb1bc3e2"

kms_key_id = "arn:aws:kms:ap-southeast-1:018907257838:alias/tpr/ebs"

global_dc_1_name = "apawipwglbdc01"

global_dc_2_name = "apawipwglbdc02"

coach_dc_1_name = "apawipwcohdc01"

dc_ami = "ami-003bcb0466a4c1ee8"

probe_instance_details = {
  "ami" : "ami-0259c5dbce44ecfff",
  "instance_type" : "t2.large",
  "iam_instance_profile" : "TEST_SSM_ROLE",
  "name" : "apawipwinfapp01",
  "key_name" : "windowsamiaccess",
  "az_letter" : "c"
}

probe_volumes = {
  "data-ebs" = {
    size        = 100
    type        = "gp2"
    device_name = "xvdb"
  }
}

root_volume_size = 70