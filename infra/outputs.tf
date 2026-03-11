output "account_id" {
  description = "ID da conta AWS"
  value = data.aws_caller_identity.current.account_id
}