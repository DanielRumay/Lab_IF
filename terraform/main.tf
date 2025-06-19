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
  name         = "Recetas"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

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

# S3 para frontend
resource "aws_s3_bucket" "frontend" {
  bucket = "your-frontend-bucket-name"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"  # Si tienes una página de error
  }
}

# ACM (SSL certificado)
resource "aws_acm_certificate" "example" {
  domain_name       = "your-domain.com"
  validation_method = "DNS"

  tags = {
    Name = "example"
  }
}

# CloudFront distribución
resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = aws_s3_bucket.frontend.bucket_regional_domain_name
    origin_id   = "S3-Frontend"

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/your-identity"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for the Frontend"
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "S3-Frontend"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods {
      items = ["GET", "HEAD"]
    }
    cached_methods {
      items = ["GET", "HEAD"]
    }
    forward_cookie {
      forward = "none"
    }
    forward_query_string = false
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.example.arn
    ssl_support_method  = "sni-only"
  }

  price_class = "PriceClass_100"  # Puedes cambiarlo dependiendo del costo y la región

  logging_config {
    include_cookies = false
    bucket          = "logs.your-bucket-name.s3.amazonaws.com"
    prefix          = "cloudfront-logs/"
  }
}

# Módulos para organizarlos (en main.tf principal)
module "cloudfront" {
  source = "./modules/cloudfront"
}

module "s3" {
  source = "./modules/s3"
}

module "acm" {
  source = "./modules/acm"
}