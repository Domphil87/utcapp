output "sns_topic_arn" {
  description = "ARN of the SNS alert topic"
  value       = aws_sns_topic.alerts.arn
}

output "sns_topic_name" {
  description = "Name of the SNS alert topic"
  value       = aws_sns_topic.alerts.name
}

output "cpu_alarm_name" {
  description = "Name of the EC2 high CPU CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu_high.alarm_name
}

output "cpu_alarm_arn" {
  description = "ARN of the EC2 high CPU CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu_high.arn
}