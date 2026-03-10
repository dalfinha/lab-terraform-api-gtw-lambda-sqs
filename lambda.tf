module "lambda" {

  source  = "terraform-aws-modules/lambda/aws"

  function_name = "processor-${var.api_gateway_name}"
  description   = "Lambda para processamento de compras recebidas pelo API Gateway ${var.api_gateway_name}"

  handler = "lambda_function.handler"
  runtime = "python3.14"

  source_path = "../code"

  tags = {
    environment    = var.environment
    repository     = "lab-terraform-api-gtw-lambda-sqs"
    repository_id  = var.github_repository_id
  }
}