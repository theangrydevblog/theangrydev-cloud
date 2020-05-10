resource "aws_s3_bucket" "angrybucket" {
  bucket = var.name
  acl = var.acl

  cors_rule {
  allowed_headers = ["*"]
  allowed_methods = ["PUT", "POST"]
  allowed_origins = ["https://www.theangrydev.io"]
  max_age_seconds = 3000
}
}
