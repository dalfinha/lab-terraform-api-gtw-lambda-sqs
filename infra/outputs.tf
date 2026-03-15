output "account_id" {
  description = "ID da conta AWS"
  value = data.aws_caller_identity.current.account_id
}

output "function_name" {
  description = "Nome da função lambda"
  value = module.lambda.lambda_function_name
}