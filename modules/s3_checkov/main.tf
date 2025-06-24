variable "bucket_name" {}

resource "aws_s3_bucket" "checkov" {
  bucket        = var.bucket_name
  force_destroy = true
}
