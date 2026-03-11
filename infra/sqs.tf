module "sqs_queue" {
  depends_on = [ module.iam_role ]

  source  = "terraform-aws-modules/sqs/aws"

  name     = "queue-${var.project_name}"

  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400

  tags = local.all_tags
}