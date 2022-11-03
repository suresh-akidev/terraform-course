# Input Variables
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 Instance Type - Instance Sizing"
  type = string
  default = "t2.micro"
  #default = "t2.small"
}

variable "package_name" {
  description = "Provide Package that need to be installed with user_data"
  type = string
  default = "httpd"
}

variable "cidr_ip_ranges" {
  type = map(list(string))
  default =   {
                "web" = ["10.0.1.0/24","10.0.2.0/24"], 
                "app" = ["10.0.11.0/24","10.0.12.0/24"], 
                "db" = ["10.0.21.0/24","10.0.22.0/24"], 
              }
            
}