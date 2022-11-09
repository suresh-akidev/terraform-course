
variable "ingress_security_group" {
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

variable "egress_security_group" {
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

variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string

}

variable "instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 1
}


variable "security_group_name" {
  type = string
}

variable "user_data_script" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}