module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "policy-${var.project_name}-sqs"
  description = "Politica IAM para permitir que a Lambda envie mensagens para a SQS"

  policy = file("${path.module}/policy/policy-lab-sqs.json")

  tags = local.all_tags
}

module "iam_role" {
  depends_on = [ module.iam_policy ]
  
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"

  name = "role-${var.project_name}-lambda"

  trust_policy_permissions = {
    LambdaAssumeRole = {
      actions = [
        "sts:AssumeRole"
      ]

      principals = [
        {
          type = "Service"
          identifiers = [
            "lambda.amazonaws.com"
          ]
        }
      ]

      condition = [
        {
          test     = "StringEquals"
          variable = "aws:SourceAccount"
          values   = [data.aws_caller_identity.current.account_id]
        }
      ]
    }
  }

  policies = {
    LambdaBasicExecutionPolicy = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    SQSBasicExecutionPolicy    =  module.iam_policy.arn
  }

  tags = local.all_tags
}