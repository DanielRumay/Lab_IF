resource "aws_s3_bucket" "frontend" {
  bucket = "recetas-frontend-bucket"
}

resource "aws_s3_bucket_acl" "frontend_acl" {
  bucket = aws_s3_bucket.frontend.id
  acl    = "public-read"
}
