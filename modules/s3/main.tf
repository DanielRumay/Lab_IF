resource "aws_s3_bucket" "frontend" {
  bucket = "recetas-frontend-bucket"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket" "multimedia" {
  bucket = "recetas-multimedia-bucket"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "multimedia_block" {
  bucket = aws_s3_bucket.multimedia.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
