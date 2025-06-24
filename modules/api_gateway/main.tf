variable "api_name" {}

resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = "API Gateway para backend de recetas"
}