output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "availability_zones" {
  description = "Availability Zones used"
  value       = module.network.availability_zones
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.network.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "Private application subnet IDs"
  value       = module.network.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  description = "Private database subnet IDs"
  value       = module.network.private_db_subnet_ids
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"
  value       = module.network.nat_gateway_ids
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = module.security_groups.alb_security_group_id
}

output "app_security_group_id" {
  description = "Application security group ID"
  value       = module.security_groups.app_security_group_id
}

output "db_security_group_id" {
  description = "Database security group ID"
  value       = module.security_groups.db_security_group_id
}