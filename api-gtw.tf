module "api_gateway" {

  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = var.api_gateway_name
  description   = "API Gateway ${var.api_gateway_name} provisionado para o consumo de eventos de compras"
  protocol_type = "HTTP"

  routes        = local.routes_api_gateway
}