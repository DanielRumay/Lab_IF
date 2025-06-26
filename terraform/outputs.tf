output "vpc_id" {
  value = module.vpc.vpc_id
}

output "lambda_function_name" {
  value = module.lambda.function_name
}

output "jenkins_public_ip" {
  value = module.ec2.public_ip
}

output "api_invoke_url" {
  value = module.api_gateway.api_invoke_url
}
