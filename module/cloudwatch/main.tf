resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = var.cpu_threshold

  dimensions = {
    InstanceId = var.instance_id
  }

  alarm_description = "This metric monitors EC2 CPU utilization"

  tags = var.tags
}
