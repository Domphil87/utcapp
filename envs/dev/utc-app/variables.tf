variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "az_count" {
  type = number
}

variable "single_nat_gateway" {
  type = bool
}

variable "bucket_name" {
  description = "S3 bucket name for the environment"
  type        = string
}

variable "tags" {
  type = map(string)
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
}

variable "db_engine_version" {
  description = "MySQL engine version"
  type        = string
}

variable "db_multi_az" {
  description = "Whether to deploy RDS in Multi-AZ"
  type        = bool
}

variable "db_backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
}

variable "db_deletion_protection" {
  description = "Whether to prevent accidental database deletion"
  type        = bool
}

variable "db_skip_final_snapshot" {
  description = "Whether to skip the final snapshot when destroying the database"
  type        = bool
}


variable "instance_type" {
  description = "EC2 instance type for the application tier"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of application instances"
  type        = number
}

variable "min_size" {
  description = "Minimum number of application instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of application instances"
  type        = number
}


variable "alarm_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU utilization percentage that triggers the alarm"
  type        = number
  default     = 70
}


variable "domain_name" {
  description = "Domain name for the development environment"
  type        = string
}


variable "route53_hosted_zone_id" {
  description = "Route 53 hosted zone ID for the application domain"
  type        = string
}


variable "origin_domain_name" {
  description = "DNS name used by CloudFront to connect to the ALB over HTTPS"
  type        = string
}