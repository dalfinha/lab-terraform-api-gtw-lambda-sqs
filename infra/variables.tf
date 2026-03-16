variable "environment" {
  type        = string
  description = "Ambiente (ex: dev, hom, prod). Será o mesmo stage da API Gateway."
  validation {
    condition     = contains(["dev", "hom", "prod"], var.environment)
    error_message = "O ambiente deve ser: dev, hom ou prod."
  }
}

variable "region" {
  type        = string
  description = "Região onde os recursos serão criados na AWS."
}

variable "project_name" {
  type        = string
  description = "Nome do Projeto, caso queira customizar."
  default     = "lab-terraform-workshop"
}