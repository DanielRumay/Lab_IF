output "bucket_name" {
  value = var.bucket_name
}

output "cloudfront_domain" {
  value = module.cloudfront.cdn.domain_name
}
