resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-${var.environment}-alerts"

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-alerts"
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  alarm_name = "${var.project_name}-${var.environment}-ec2-high-cpu"

  alarm_description = "Triggers when the EC2 Auto Scaling Group average CPU utilization is too high."

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  statistic = "Average"
  period    = var.period

  evaluation_periods = var.evaluation_periods
  threshold          = var.cpu_threshold

  comparison_operator = "GreaterThanOrEqualToThreshold"

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  ok_actions = [
    aws_sns_topic.alerts.arn
  ]

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-ec2-high-cpu"
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}