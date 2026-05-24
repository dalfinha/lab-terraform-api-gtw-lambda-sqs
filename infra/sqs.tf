module "sqs_queue" {
  source  = "terraform-aws-modules/sqs/aws"

  name     = "queue-${var.project_name}"

  visibility_timeout_seconds = 30
  message_retention_seconds  = 120
  
  create_queue_policy = true

  queue_policy_statements = {
    allow_account_only = {
      sid     = "AllowSendMessageLimitedToMyAccountOnly"
      actions = ["sqs:SendMessage"]
      principals = [{
        type        = "AWS"
        identifiers = ["*"]
      }]
      conditions = [{
        test     = "StringEquals"
        variable = "aws:SourceAccount"
        values   = [data.aws_caller_identity.current.account_id]
      }]
    }
  }

  tags = local.all_tags
}