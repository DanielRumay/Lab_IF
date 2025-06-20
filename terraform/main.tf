terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"
}

module "s3" {
  source = "../modules/s3"
}

module "lambda" {
  source = "../modules/lambda"
}

module "api_gateway" {
  source = "../modules/api_gateway"
  lambda_invoke_arn = module.lambda.function_invoke_arn
}

module "cognito" {
  source = "../modules/cognito"
}