module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"

  #configuracoes padrao
  function_name = "lambda-${var.project_name}"
  description   = "Lambda para processamento de compras recebidas pelo API Gateway ${var.api_gateway_name} e processamento com a fila ${module.sqs_queue.queue_name}."

  handler = "lambda_function.handler"
  runtime = "python3.13"

  create_unqualified_alias_allowed_triggers = true
  source_path = [ {
    path = "../code/lambda_function.py"
    pip_requirements = "../code/requirements.txt"
  }]

  #variaveis de ambiente usadas no codigo
  environment_variables = {
    QUEUE_URL = module.sqs_queue.queue_url
  }

  #associa o api gateway como trigger inicial
  #allowed_triggers = {
  #  AllowExecutionFromAPIGateway = {
  #     service    = "apigateway"
  #    source_arn = module.api_gateway.api_execution_arn
  #    qualifier
  #  }
  #}

  #politica para enviar mensagens ao sqs
  attach_policy_statements = true
  policy_statements = {
    sqs = {
      effect  = "Allow",
      actions = ["sqs:SendMessage"],
      resources = [module.sqs_queue.queue_arn]
    }
  }

  tags = local.all_tags
}