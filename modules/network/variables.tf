variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "az_count" {
  description = "Number of Availability Zones to use"
  type        = number

  validation {
    condition     = var.az_count >= 2 && var.az_count <= 3
    error_message = "az_count must be either 2 or 3."
  }
}

variable "single_nat_gateway" {
  description = "Use one NAT Gateway instead of one NAT Gateway per AZ"
  type        = bool
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}