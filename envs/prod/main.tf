module "network" {
  source = "../../../modules/network"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr

  az_count           = var.az_count
  single_nat_gateway = var.single_nat_gateway

  tags = var.tags
}

module "security_groups" {
  source = "../../../modules/security-groups"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.network.vpc_id

  tags = var.tags
}