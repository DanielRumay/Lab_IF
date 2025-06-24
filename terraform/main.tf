terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "recetas-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source              = "../modules/vpc"
  cidr_block          = var.vpc_cidr
  subnet_cidrs        = var.subnet_cidrs
  availability_zones  = var.availability_zones
}

module "security_groups" {
  source  = "../modules/security_groups"
  vpc_id  = module.vpc.vpc_id
}

module "ec2" {
  source              = "../modules/ec2"
  ami_id              = var.jenkins_ami
  instance_type       = var.instance_type
  subnet_id           = module.vpc.private_subnet_ids[0]
  security_group_id   = module.security_groups.jenkins_sg_id
}

module "grafana" {
  source              = "../modules/grafana"
  ami_id              = var.jenkins_ami
  instance_type       = var.instance_type
  subnet_id           = module.vpc.private_subnet_ids[0]
  security_group_id   = module.security_groups.jenkins_sg_id
}

module "iam" {
  source = "../modules/iam"
}

module "lambda" {
  source        = "../modules/lambda"
  function_name = var.lambda_function_name
  filename      = var.lambda_package
  handler       = var.lambda_handler
  role_arn      = module.iam.lambda_exec_role_arn
}

module "cloudwatch" {
  source        = "../modules/cloudwatch"
  function_name = var.lambda_function_name
}

module "rds" {
  source            = "../modules/rds"
  db_user           = var.db_user
  db_password       = var.db_password
  db_subnet_group   = module.vpc.db_subnet_group_name
  security_group_id = module.security_groups.rds_sg_id
}

module "s3_frontend" {
  source      = "../modules/s3/frontend"
  bucket_name = "recetas-frontend"
}

module "s3_multimedia" {
  source      = "../modules/s3/multimedia"
  bucket_name = var.s3_multimedia_bucket
}

module "s3_checkov" {
  source      = "../modules/s3_checkov"
  bucket_name = var.s3_checkov_bucket_name
}

module "api_gateway" {
  source   = "../modules/api_gateway"
  api_name = var.api_name
}

module "cloudfront" {
  source                       = "../modules/cloudfront"
  bucket_regional_domain_name = module.s3_frontend.bucket_domain_name
}

module "route53" {
  source                 = "../modules/route53"
  zone_id                = var.zone_id
  record_name            = var.domain_name
  cloudfront_domain_name = module.cloudfront.domain_name
  cloudfront_zone_id     = module.cloudfront.zone_id
}