locals {
  all_tags = {
    environment    = var.environment
    repository     = "lab-terraform-api-gtw-lambda-sqs"
    repository_id  = var.github_repository_id
  }

  routes_api_gateway = {
    "POST /compras" = {
      lambda_function_name   = module.lambda.function_name
      payload_format_version = "2.0"
      timeout_milliseconds   = 30
    }
  }
}