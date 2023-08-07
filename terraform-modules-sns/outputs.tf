output "sns-topic-arn" {
  value = aws_sns_topic.topic.arn
}
output "sns-topic-name" {
  value = aws_sns_topic.topic.display_name
}
output "fallback-topic-arn" {
  value = aws_sns_topic.fallback_topic.arn
}
