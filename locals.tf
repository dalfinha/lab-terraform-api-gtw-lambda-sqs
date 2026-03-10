locals {
  all_tags = {
    environment    = var.environment
    repository     = "lab-terraform-api-gtw-lambda-sqs"
    repository_id  = var.github_repository_id
  }
}