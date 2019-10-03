region = "us-west-2"

role_arn = "arn:aws:iam::018907257838:role/techservices-terraform-role"

environment = "sharedservices"

terraform_workspace = "sharedservices-us-west-2"

state_bucket_name = "techservices-us-east-1-sharedservices-state-bucket"

state_key_vpc = "vpc/terraform.tfstate"

state_bucket_region = "us-east-1"

subnet_usawipwcohdc01 = "subnet-0f5722c0b1fe628ee"

subnet_usawipwglbdc01 = "subnet-0a88f57d7e06db951"

subnet_usawipwglbdc02 = "subnet-0ef7066fb8590a77b"

kms_key_id = "arn:aws:kms:us-west-2:018907257838:key/b0dd5d04-fa84-4062-9a2e-1531eae21876"

global_dc_1_name = "usawipwglbdc03"

global_dc_2_name = "usawipwglbdc04"

coach_dc_1_name = "usawipwcohdc02"

probe_instance_details = {
  "ami" : "ami-0d705356e2616369c",
  "instance_type" : "t2.large",
  "iam_instance_profile" : "TEST_SSM_ROLE",
  "name" : "usawipwinfapp02",
  "key_name" : "authentication-prod-key",
  "az_letter" : "b"
}

probe_volumes = {
  "data-ebs" = {
    size        = 100
    type        = "gp2"
    device_name = "xvdb"
  }
}