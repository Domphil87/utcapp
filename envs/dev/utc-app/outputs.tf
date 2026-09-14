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

output "s3_bucket_id" {
  description = "S3 bucket ID"
  value       = module.storage.bucket_id
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.storage.bucket_arn
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = module.storage.bucket_name
}


output "db_instance_id" {
  description = "RDS database instance ID"
  value       = module.database.db_instance_id
}

output "db_instance_arn" {
  description = "RDS database instance ARN"
  value       = module.database.db_instance_arn
}

output "db_endpoint" {
  description = "RDS database endpoint"
  value       = module.database.db_endpoint
}

output "db_address" {
  description = "RDS database hostname"
  value       = module.database.db_address
}

output "db_port" {
  description = "RDS database port"
  value       = module.database.db_port
}


output "ec2_role_name" {
  description = "EC2 IAM role name"
  value       = module.iam.ec2_role_name
}

output "ec2_role_arn" {
  description = "EC2 IAM role ARN"
  value       = module.iam.ec2_role_arn
}

output "ec2_instance_profile_name" {
  description = "EC2 instance profile name"
  value       = module.iam.ec2_instance_profile_name
}

output "ec2_instance_profile_arn" {
  description = "EC2 instance profile ARN"
  value       = module.iam.ec2_instance_profile_arn
}


output "launch_template_id" {
  description = "Application EC2 launch template ID"
  value       = module.ec2.launch_template_id
}

output "launch_template_arn" {
  description = "Application EC2 launch template ARN"
  value       = module.ec2.launch_template_arn
}

output "autoscaling_group_name" {
  description = "Application EC2 Auto Scaling Group name"
  value       = module.ec2.autoscaling_group_name
}

output "autoscaling_group_arn" {
  description = "Application EC2 Auto Scaling Group ARN"
  value       = module.ec2.autoscaling_group_arn
}


output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "alb_target_group_arn" {
  description = "ARN of the ALB target group"
  value       = module.alb.target_group_arn
}


output "sns_topic_arn" {
  description = "SNS topic ARN for monitoring alerts"
  value       = module.monitoring.sns_topic_arn
}

output "sns_topic_name" {
  description = "SNS topic name for monitoring alerts"
  value       = module.monitoring.sns_topic_name
}

output "ec2_cpu_alarm_name" {
  description = "CloudWatch alarm for high EC2 CPU utilization"
  value       = module.monitoring.cpu_alarm_name
}

output "ec2_cpu_alarm_arn" {
  description = "CloudWatch alarm ARN for high EC2 CPU utilization"
  value       = module.monitoring.cpu_alarm_arn
}


output "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = module.acm.certificate_arn
}


output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.cloudfront.distribution_id
}

output "cloudfront_distribution_domain_name" {
  description = "CloudFront distribution domain name"
  value       = module.cloudfront.distribution_domain_name
}

output "cloudfront_distribution_arn" {
  description = "CloudFront distribution ARN"
  value       = module.cloudfront.distribution_arn
}


output "application_domain" {
  description = "Application domain name"
  value       = module.route53.domain_name
}

output "route53_a_record" {
  description = "Route 53 A record"
  value       = module.route53.a_record_name
}

output "route53_aaaa_record" {
  description = "Route 53 AAAA record"
  value       = module.route53.aaaa_record_name
}