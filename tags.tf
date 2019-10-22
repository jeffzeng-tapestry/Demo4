module "tags" {
  source = "git@github.com:tapestryinc/TF-AWS-Tags-Module.git?ref=v1.3.0"

  dr_tier              = var.tags.dr_tier
  cost_center          = var.tags.cost_center
  application_id       = var.tags.application_id
  project_name         = var.tags.project_name
  app_partner          = var.tags.app_partner
  cpm_backup           = var.tags.cpm_backup
  environment          = var.tags.environment
  cloud_custodian_tags = var.tags.cloud_custodian_tags
  compliance           = var.tags.compliance
  brand                = var.tags.brand
  os                   = var.tags.os
  tf_repo              = var.tags.tf_repo
}