module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 5.0"

  name          = "api-${var.project_name}"
  description   = "API Gateway api-${var.project_name} provisionado para o consumo de eventos de compras"
  protocol_type = "HTTP"

  body = templatefile("${path.module}/api/api-lab-terraform-api-gtw-lambda-sqs.yaml", {
    lambda_arn = module.lambda.lambda_function_arn
  })

  stage_name         = var.environment
  create_domain_name = false
  create_domain_records = false
  
  tags = local.all_tags
}