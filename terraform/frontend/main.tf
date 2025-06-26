module "frontend_bucket" {
  source      = "../../modules/s3/frontend"
  bucket_name = var.bucket_name
}

module "cloudfront" {
  source                      = "../../modules/cloudfront"
  bucket_regional_domain_name = module.frontend_bucket.bucket_domain_name
}