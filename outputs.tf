output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "lambda_name" {
  value = aws_lambda_function.mi_lambda.function_name
}