# Define Output Values

# Attribute Reference
output "ec2_instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.my-ec2-vm[*].public_ip
  #value = [for temp_var in aws_instance.my-ec2-vm : temp_var.public_ip]
}

# Attribute Reference - Create Public DNS URL 
output "ec2_publicdns" {
  description = "Public DNS URL of an EC2 Instance"
  value = aws_instance.my-ec2-vm[*].public_dns
  #value = [for temp_var in aws_instance.my-ec2-vm : temp_var.public_dns]
}

# ELB DNS Name
output "elb_dns_name" {
  description = "ELB DNS Name"
  value = aws_elb.elb[*].dns_name
  #value = [for temp_var in aws_elb.elb : temp_var.dns_name]
}