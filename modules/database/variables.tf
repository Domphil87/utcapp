variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the database will be created"
  type        = string
}

variable "private_db_subnet_ids" {
  description = "Private subnet IDs for the RDS DB subnet group"
  type        = list(string)
}

variable "db_security_group_id" {
  description = "Security group ID for the RDS database"
  type        = string
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

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
}

variable "engine_version" {
  description = "MySQL engine version"
  type        = string
}

variable "multi_az" {
  description = "Whether to deploy the RDS instance in Multi-AZ"
  type        = bool
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
}

variable "deletion_protection" {
  description = "Whether to prevent accidental database deletion"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when the database is destroyed"
  type        = bool
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}