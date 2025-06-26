variable "api_name" {
  description = "Nombre del API Gateway"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "ARN de invocación de la función Lambda"
  type        = string
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda"
  type        = string
}

variable "region" {
  description = "Región AWS donde se despliega el API"
  type        = string
}