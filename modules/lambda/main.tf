variable "function_name" {}
variable "filename" {}
variable "handler" {}
variable "role_arn" {}

resource "aws_lambda_function" "recetas_lambda" {
  function_name = var.function_name
  filename      = var.filename
  handler       = var.handler
  role          = var.role_arn
  runtime       = "python3.9"
}

output "function_name" {
  value = aws_lambda_function.recetas_lambda.function_name
}