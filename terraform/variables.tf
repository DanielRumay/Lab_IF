variable "jenkins_ami" {}
variable "instance_type" {}
variable "subnet_cidrs" { type = list(string) }
variable "availability_zones" { type = list(string) }
variable "vpc_cidr" {}
variable "db_user" {}
variable "db_password" {}
variable "lambda_function_name" {}
variable "lambda_package" {}
variable "lambda_handler" {}
variable "s3_checkov_bucket_name" {}
variable "s3_multimedia_bucket" {}
variable "zone_id" {}
variable "domain_name" {}
variable "api_name" {}
variable "region" {
  description = "Región AWS para desplegar recursos"
  type        = string
}
