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

module "storage" {
  source = "../../../modules/storage"

  project_name = var.project_name
  environment  = var.environment
  bucket_name  = var.bucket_name

  tags = var.tags
}


module "database" {
  source = "../../../modules/database"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.network.vpc_id

  private_db_subnet_ids = module.network.private_db_subnet_ids

  db_security_group_id = module.security_groups.db_security_group_id

  db_name           = var.db_name
  db_username       = var.db_username
  db_instance_class = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  engine_version    = var.db_engine_version

  multi_az                = var.db_multi_az
  backup_retention_period = var.db_backup_retention_period
  deletion_protection     = var.db_deletion_protection
  skip_final_snapshot     = var.db_skip_final_snapshot

  tags = var.tags
}


module "iam" {
  source = "../../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags
}


module "ec2" {
  source = "../../../modules/ec2"

  project_name = var.project_name
  environment  = var.environment

  private_app_subnet_ids = module.network.private_app_subnet_ids

  app_security_group_id = module.security_groups.app_security_group_id

  ec2_instance_profile_name = module.iam.ec2_instance_profile_name

  instance_type    = var.instance_type
  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  tags = var.tags
}


module "alb" {
  source = "../../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.network.vpc_id

  public_subnet_ids = module.network.public_subnet_ids

  alb_security_group_id = module.security_groups.alb_security_group_id

  autoscaling_group_name = module.ec2.autoscaling_group_name

  certificate_arn = module.acm_origin.certificate_arn

  tags = var.tags
}


module "monitoring" {
  source = "../../../modules/monitoring"

  project_name = var.project_name
  environment  = var.environment

  autoscaling_group_name = module.ec2.autoscaling_group_name

  alarm_email   = var.alarm_email
  cpu_threshold = var.cpu_threshold

  tags = var.tags
}


module "acm" {
  source = "../../../modules/acm"

  project_name   = var.project_name
  environment    = var.environment
  domain_name    = var.domain_name
  hosted_zone_id = var.route53_hosted_zone_id

  tags = var.tags
}


module "cloudfront" {

  source = "../../../modules/cloudfront"

  project_name = var.project_name
  environment  = var.environment
  domain_name  = var.domain_name

  certificate_arn = module.acm.certificate_arn

  origin_domain_name = var.origin_domain_name

  tags = var.tags

}


module "acm_origin" {
  source = "../../../modules/acm"

  project_name   = var.project_name
  environment    = var.environment
  domain_name    = var.origin_domain_name
  hosted_zone_id = var.route53_hosted_zone_id

  tags = var.tags
}


module "route53" {
  source = "../../../modules/route53"

  project_name = var.project_name
  environment  = var.environment
  domain_name  = var.domain_name

  hosted_zone_id = var.route53_hosted_zone_id

  cloudfront_domain_name    = module.cloudfront.distribution_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.distribution_hosted_zone_id

  origin_domain_name = var.origin_domain_name
  alb_dns_name       = module.alb.alb_dns_name
  alb_zone_id        = module.alb.alb_zone_id

  tags = var.tags
}