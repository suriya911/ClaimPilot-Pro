output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "documents_bucket" {
  value = aws_s3_bucket.documents.bucket
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "sns_alert_topic_arn" {
  value = aws_sns_topic.alerts.arn
}
