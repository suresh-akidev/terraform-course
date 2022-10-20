
resource "aws_instance" "my-ec2-vm" {
  ami           = "ami-062df10d14676e201"
  instance_type = var.instance_type
  key_name      = "ec2_key_pair"
	user_data = file("apache-install.sh")  
  vpc_security_group_ids = ["sg-04845a3a2d27672c7"]
  tags = {
    "Name" = "linux-vm"
  }
  availability_zone = "ap-south-1b"
}




