module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"

  function_name = "lambda-${var.project_name}"
  description   = "Lambda para processamento de compras recebidas pelo API Gateway ${var.api_gateway_name} e processamento com a fila ${module.sqs_queue.queue_name}"

  handler = "lambda_function.handler"
  runtime = "python3.13"

  source_path = "../code"

  environment_variables = {
    QUEUE_URL = module.sqs_queue.queue_url
  }

  role_name = module.iam_role.name

  tags = local.all_tags
}