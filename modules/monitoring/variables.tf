variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "autoscaling_group_name" {
  description = "Name of the EC2 Auto Scaling Group to monitor"
  type        = string
}

variable "alarm_email" {
  description = "Email address that will receive SNS notifications"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU utilization percentage that triggers the alarm"
  type        = number
  default     = 70
}

variable "evaluation_periods" {
  description = "Number of consecutive periods evaluated by the alarm"
  type        = number
  default     = 5
}

variable "period" {
  description = "CloudWatch metric evaluation period in seconds"
  type        = number
  default     = 60
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}