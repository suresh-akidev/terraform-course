module "ec2_instnaces" {
  source = "./modules/ec2_instances"

  ec2_instance_count = var.instance_count
  ec2_ami_id = data.aws_ami.amzlinux.id
  ec2_ingress_security_group = var.ingress_security_group
  ec2_egress_security_group = var.egress_security_group
  ec2_security_group_name = var.security_group_name
  ec2_user_data_script = var.user_data_script
  ec2_instance_name = var.instance_name
  ec2_key_name = var.key_name
  ec2_instance_type = var.instance_type

}