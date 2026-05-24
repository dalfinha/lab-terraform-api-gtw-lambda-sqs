output "account_id" {
  description = "ID da conta AWS"
  value = data.aws_caller_identity.current.account_id
}

output "region_id" {
  description = "ID da região AWS"
  value = data.aws_region.current.id
} 

output "function_name" {
  description = "Função Lambda"
  value = module.lambda.lambda_function_name
}

output "api_execution_arn" {
  description = "API Execution ARN"
  value = module.api_gateway.api_execution_arn
}

output "sqs_queue" {
  description = "Fila SQS"
  value = module.sqs_queue.queue_name
}

output "dns_api_gateway" {
  description = "ID do DNS do API Gateway para testes"
  value       = module.api_gateway.stage_invoke_url
}