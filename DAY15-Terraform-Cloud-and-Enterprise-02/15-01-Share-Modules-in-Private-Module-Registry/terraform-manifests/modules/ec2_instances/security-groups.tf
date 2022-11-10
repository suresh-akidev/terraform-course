
resource "aws_security_group" "vpc-sg" {
  name        = var.ec2_security_group_name
  ingress = var.ec2_ingress_security_group
  egress  = var.ec2_egress_security_group
}
