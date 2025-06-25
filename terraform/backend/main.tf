module "iam_lambda_role" {
  source = "../../modules/iam"
}

module "lambda_function" {
  source        = "../../modules/lambda"
  function_name = var.lambda_function_name
  filename      = var.lambda_package
  handler       = var.lambda_handler
  role_arn      = module.iam_lambda_role.lambda_exec_role_arn
}

module "api_gateway" {
  source              = "../../modules/api_gateway"
  lambda_invoke_arn   = module.lambda_function.invoke_arn
  api_name            = var.api_name
}
