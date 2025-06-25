output "lambda_name" {
  value = module.lambda_function.function_name
}

output "lambda_invoke_arn" {
  value = module.lambda_function.invoke_arn
}

output "api_endpoint" {
  value = module.api_gateway.api_endpoint
}
