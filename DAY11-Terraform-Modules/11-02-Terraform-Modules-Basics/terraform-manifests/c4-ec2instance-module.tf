# AWS EC2 Instance Module
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-modules-demo"
  instance_count         = 1

  ami                    = data.aws_ami.amzlinux.id 
  instance_type          = "t2.medium"
  key_name               = "ec2_key_pair"
  monitoring             = true
  vpc_security_group_ids = ["sg-085a51b739df34661"] 
  subnet_id              = "subnet-00d2838782fa3ecee" 
  user_data              = file("apache-install.sh") 
  
  tags = {
    Name        = "Modules-Demo"
    Terraform   = "true"
    Environment = "dev"
  }
}

