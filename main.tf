provider "aws" {
  region = var.region
}

# VPC básica
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}b"
}

# DynamoDB
resource "aws_dynamodb_table" "recetas" {
  name           = "Recetas"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# SNS
resource "aws_sns_topic" "notificaciones" {
  name = "Notificaciones"
}

# Cognito
resource "aws_cognito_user_pool" "user_pool" {
  name = "MiUserPool"
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "MiUserClient"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

# Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_lambda_function" "mi_lambda" {
  function_name = "MiFuncionLambda"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  filename      = "lambda_function.zip" # Asegúrate de subir este archivo a la VM

  vpc_config {
    subnet_ids         = [aws_subnet.private1.id, aws_subnet.private2.id]
    security_group_ids = []
  }
}