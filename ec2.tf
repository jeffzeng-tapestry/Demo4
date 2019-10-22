module "global_dc_1" {
  source               = "git@github.com:tapestryinc/TF-AWS-EC2-Module.git?ref=v2.0.7"
  name                 = var.global_dc_1_name
  ami                  = var.dc_ami
  instance_type        = "t2.large"
  key_name             = var.ec2_key_name
  subnet_id            = var.subnet_usawipwglbdc01
  os_type              = "windows"
  vpc_alias            = var.terraform_workspace
  security_group_ids   = [aws_security_group.ActiveDirectory.id]
  iam_instance_profile = var.ec2_iam_instance_profile
  volume_size          = var.root_volume_size
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
  tags = merge({"os" = "win2012"}, module.tags.tags)
}

module "global_dc_2" {
  source               = "git@github.com:tapestryinc/TF-AWS-EC2-Module.git?ref=v2.0.7"
  name                 = var.global_dc_2_name
  ami                  = var.dc_ami
  instance_type        = "t2.large"
  key_name             = var.ec2_key_name
  subnet_id            = var.subnet_usawipwglbdc02
  os_type              = "windows"
  vpc_alias            = var.terraform_workspace
  security_group_ids   = [aws_security_group.ActiveDirectory.id]
  iam_instance_profile = var.ec2_iam_instance_profile
  volume_size          = var.root_volume_size
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
  tags = merge({"os" = "win2012"}, module.tags.tags)
}

module "coach_dc_1" {
  source               = "git@github.com:tapestryinc/TF-AWS-EC2-Module.git?ref=v2.0.7"
  name                 = var.coach_dc_1_name
  ami                  = var.dc_ami
  instance_type        = "t2.large"
  key_name             = var.ec2_key_name
  subnet_id            = var.subnet_usawipwcohdc01
  os_type              = "windows"
  vpc_alias            = var.terraform_workspace
  security_group_ids   = [aws_security_group.ActiveDirectory.id]
  iam_instance_profile = var.ec2_iam_instance_profile
  volume_size          = var.root_volume_size
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
  tags = merge({"os" = "win2012"}, module.tags.tags)
}

module "probe" {
  source               = "git@github.com:tapestryinc/TF-AWS-EC2-Module.git?ref=v2.0.7"
  ami                  = var.probe_instance_details.ami
  instance_type        = var.probe_instance_details.instance_type
  iam_instance_profile = var.probe_instance_details.iam_instance_profile
  key_name             = var.probe_instance_details.key_name
  os_type              = "windows"
  name                 = var.probe_instance_details.name
  subnet_id            = local.subnet_map[var.probe_instance_details.az_letter]
  addl_ebs_volumes     = var.probe_volumes
  tags                 = merge({"os" = "win2016"}, module.tags.tags)
  vpc_alias            = local.account_workspace
}