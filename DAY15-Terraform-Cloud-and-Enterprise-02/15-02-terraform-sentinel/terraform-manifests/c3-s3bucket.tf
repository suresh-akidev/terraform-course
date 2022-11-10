# Create S3 Bucket Resource
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "private"
  #acl    = "public-read"
  tags          = var.tags
  force_destroy = true
}

