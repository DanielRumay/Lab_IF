resource "aws_lambda_function" "demo" {
  function_name = "demo-lambda"
  filename      = "demo_lambda.zip"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = "arn:aws:iam::123456789012:role/lambda-execution-role"
  environment {
    variables = {
      STAGE = "dev"
    }
  }
}

