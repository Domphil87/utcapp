output "launch_template_id" {
  description = "ID of the EC2 launch template"
  value       = aws_launch_template.this.id
}

output "launch_template_arn" {
  description = "ARN of the EC2 launch template"
  value       = aws_launch_template.this.arn
}

output "autoscaling_group_name" {
  description = "Name of the EC2 Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}

output "autoscaling_group_arn" {
  description = "ARN of the EC2 Auto Scaling Group"
  value       = aws_autoscaling_group.this.arn
}