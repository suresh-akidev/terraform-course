

variable "ec2_ami_id" {
  description = "AMI ID"
  type        = string

}

variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 1
}
variable "ec2_ingress_security_group" {
  type = list(object({
    protocol = string
    from_port = number
    to_port = number
    cidr_blocks = list(string)
    description = string
    ipv6_cidr_blocks = list(string)
    prefix_list_ids = list(string)
    security_groups = list(string)
    self = bool
    
  }))
}

variable "ec2_egress_security_group" {
  type = list(object({
    protocol = string
    from_port = number
    to_port = number
    cidr_blocks = list(string)
    description = string
    ipv6_cidr_blocks = list(string)
    prefix_list_ids = list(string)
    security_groups = list(string)
    self = bool
    
  }))
}

variable "ec2_security_group_name" {
  type = string
}

variable "ec2_user_data_script" {
  type = string
}

variable "ec2_instance_name" {
  type = string
}

variable "ec2_key_name" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}