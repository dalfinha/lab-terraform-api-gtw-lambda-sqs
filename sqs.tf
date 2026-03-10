module "sqs_queue" {
  source  = "terraform-aws-modules/sqs/aws"

  name     = "queue-${var.project_name}-queue"

  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400

  tags = local.all_tags
}