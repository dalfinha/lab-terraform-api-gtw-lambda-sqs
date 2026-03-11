module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 5.0"

  name          = var.api_gateway_name
  description   = "API Gateway ${var.api_gateway_name} provisionado para o consumo de eventos de compras"
  protocol_type = "HTTP"

  routes = {
    "POST /compras" = {
      integration = {
        uri                    = module.lambda.lambda_function_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 900
      }
    }
  }

  create_domain_name = false
  create_domain_records = false
  
  tags = local.all_tags
}