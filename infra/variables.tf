variable "environment" {
  type        = string
  description = "Ambiente (ex: dev, hom, prod). Será o mesmo stage da API Gateway."
  validation {
    condition     = contains(["dev", "hom", "prod"], var.environment)
    error_message = "O ambiente deve ser: dev, hom ou prod."
  }
}

variable "api_gateway_name" {
  type        = string
  description = "Nome do API Gateway."
}

variable "project_name" {
  type        = string
  description = "Nome do Projeto, caso queira customizar."
  default     = "lab-terraform-workshop"
}