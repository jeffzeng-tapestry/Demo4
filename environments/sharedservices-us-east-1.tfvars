region = "us-east-1"

role_arn = "arn:aws:iam::018907257838:role/techservices-terraform-role"

environment = "sharedservices"

terraform_workspace = "sharedservices-us-east-1"

state_bucket_name = "techservices-us-east-1-sharedservices-state-bucket"

state_key_vpc = "vpc/terraform.tfstate"

state_bucket_region = "us-east-1"

subnet_usawipwcohdc01 = "subnet-07744da281a1ccd4d"

subnet_usawipwglbdc01 = "subnet-054c247874094a088"

subnet_usawipwglbdc02 = "subnet-01db58b4fde1350eb"

kms_key_id = "arn:aws:kms:us-east-1:018907257838:key/67ffbc8f-00ea-494d-aac1-8ac4e39c25ad"

global_dc_1_name = "usawipwglbdc01"

global_dc_2_name = "usawipwglbdc02"

coach_dc_1_name = "usawipwcohdc01"

probe_instance_details = {
  "ami" : "ami-0d41aee8a57fdb850",
  "instance_type" : "t2.large",
  "iam_instance_profile" : "TEST_SSM_ROLE",
  "name" : "usawipwinfapp01",
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