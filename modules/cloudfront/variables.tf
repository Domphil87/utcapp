variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "domain_name" {
  description = "Custom domain name for CloudFront"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN for CloudFront"
  type        = string
}


variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}


variable "origin_domain_name" {
  description = "DNS name CloudFront uses to connect to the ALB origin"
  type        = string
}