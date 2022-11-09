# Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_key_name
  count                  = var.ec2_instance_count
  user_data = file(var.ec2_user_data_script)
  vpc_security_group_ids = [aws_security_group.vpc-sg.id]
  tags = {
    "Name" = var.ec2_instance_name
  }
}
