resource "aws_instance" "myec2-import" {
  ami = "ami-09d3b3274b6c5d4aa"
  instance_type = "t2.medium"
  tags = {
    "Name" = "test"
  }
}

resource "aws_s3_bucket" "bucket-import" {
  bucket = "new-bucket-157673692367"
  force_destroy = false
  acl = "private"
}