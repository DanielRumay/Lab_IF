variable "bucket_name" {}

resource "aws_s3_bucket" "frontend" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.bucket
  index_document {
    suffix = "index.html"
  }
}

output "bucket_domain_name" {
  value = aws_s3_bucket.frontend.bucket_regional_domain_name
}
