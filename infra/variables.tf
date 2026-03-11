variable "environment" {
  type        = string
  description = "Ambiente (ex: dev, hom, prod)"

  validation {
    condition     = contains(["dev", "hom", "prod"], var.environment)
    error_message = "O ambiente deve ser: dev, hom ou prod."
  }
}

variable "api_gateway_name" {
  type        = string
  description = "Nome do API Gateway"
  default     = "lab-api-gateway-events"
}

variable "github_repository_id" {
  type        = string
  default     = "GITHUB_REPOSITORY_ID_PLACEHOLDER"
}

variable "project_name" {
  type        = string
  default     = "worshop-lab"
}