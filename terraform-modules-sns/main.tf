resource "aws_sns_topic" "topic" {
  name = var.sns-topic
}
resource "aws_sns_topic_policy" "topic_policy" {
  arn = aws_sns_topic.topic.arn

  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "Sid1",
        Effect    = "Allow",
        Principal = {
          Service = [
            "events.amazonaws.com", # Allow CloudWatch Events
            "budgets.amazonaws.com", # Allow Budget Notifications
            "rds.amazonaws.com", # Allow RDS Events
            "s3.amazonaws.com", # Allow S3 Event Notifications
            "backup.amazonaws.com", # Allow Backup Events
            "codestar-notifications.amazonaws.com", # Allow CodeStar Notifications
          ]
        }
        Action    = "sns:Publish",
        Resource  = aws_sns_topic.topic.arn
      },
      {
        Sid       = "Sid2",
        Effect    = "Allow",
        Principal = {
          AWS = "*", # Allow CloudWatch Alarms, ElastiCache Notifications, Elastic Beanstalk Notifications, Auto Scaling Notification
        }
        Action    = "sns:Publish",
        Resource  = aws_sns_topic.topic.arn
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" = data.aws_caller_identity.current.account_id
          }
        }
      },
      {
        Sid       = "Sid3"
        Effect    = "Allow"
        Principal = {
          Service = "ses.amazonaws.com" # Allow SES Notifications & Events
        }
        Action    = "sns:Publish"
        Resource  = aws_sns_topic.topic.arn
        Condition = {
          StringEquals = {
            "AWS:Referer" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}

resource "aws_sns_topic" "fallback_topic" {
  name = var.fallback-topic
}

resource "aws_cloudwatch_metric_alarm" "number_of_notifications_failed_too_high_alarm" {
   alarm_name = var.cloudwatch-alarm
   comparison_operator = "GreaterThanThreshold"
   evaluation_periods  = 1
   metric_name         = "NumberOfNotificationsFailed"
   namespace           = "AWS/SNS"
   period              = 60
   statistic           = "Sum"
   threshold           = 0

  alarm_description = "Alerts could not be delivered"

  alarm_actions = [aws_sns_topic.fallback_topic.arn]
  

  dimensions = {
    TopicName = aws_sns_topic.topic.name
  }
}

resource "aws_sns_topic_subscription" "email_subscription" {
  count = var.has_email ? 1 : 0
  topic_arn = aws_sns_topic.topic.arn
  protocol = "email"
  endpoint = var.email

  delivery_policy = jsonencode({
    healthyRetryPolicy = {
      minDelayTarget    = 1
      maxDelayTarget    = 60
      numRetries        = 100
      numNoDelayRetries = 0
      backoffFunction   = "exponential"
    }
    throttlePolicy = {
      maxReceivesPerSecond = 1
    }

  })
}

resource "aws_sns_topic_subscription" "http_endpoint_subscription" {
  
  count = var.has_http_endpoint ? 1 : 0

  topic_arn = aws_sns_topic.topic.arn
  protocol  = "http"
  endpoint  = var.http_endpoint

  delivery_policy = jsonencode({
    healthyRetryPolicy = {
      minDelayTarget    = 1
      maxDelayTarget    = 60
      numRetries        = 100
      numNoDelayRetries = 0
      backoffFunction   = "exponential"
    }
    throttlePolicy = {
      maxReceivesPerSecond = 1
    }

  })
}

resource "aws_sns_topic_subscription" "https_endpoint_subscription" {
  count = var.has_https_endpoint ? 1 : 0

  topic_arn = aws_sns_topic.topic.arn
  protocol  = "https"
  endpoint  = var.https_endpoint
  
  delivery_policy = jsonencode({
    healthyRetryPolicy = {
      minDelayTarget    = 1
      maxDelayTarget    = 60
      numRetries        = 100
      numNoDelayRetries = 0
      backoffFunction   = "exponential"
    }
    throttlePolicy = {
      maxReceivesPerSecond = 1
    }

  })
  
}

resource "aws_sns_topic_subscription" "fallback_email_subscription" {
  count = var.has_fallback_email ? 1 : 0

  topic_arn = aws_sns_topic.fallback_topic.arn
  protocol  = "email"
  endpoint  = var.fallback_email
}
