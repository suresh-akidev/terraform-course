# Create EC2 Instance
resource "aws_instance" "web" {
  ami = "ami-0915bcb5fa77e4892" # Amazon Linux
  instance_type = "t2.medium"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "web-2"
  }
  lifecycle {
    prevent_destroy = true # Default is false
  }
}

