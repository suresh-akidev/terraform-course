data "aws_vpc" "get_vpc_id" {
  filter {
    name = "state"
    values = ["available"]
  }
}

data "aws_subnet" "get_subnet_id" {
  #vpc_id = data.aws_vpc.get_vpc_id.id
  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }

}

resource "aws_security_group" "terra_sg" {
  name = "terra-sg"
  description = "terraform course security group"
  vpc_id = data.aws_vpc.get_vpc_id.id
  ingress = [ {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Inbound Terraform Security Group"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
    
  },
  {
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Outbound Terraform Security Group"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false 
  },
  {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Inbound Terraform Security Group"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false 
  }
]

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
   "Environment" = "DEV"
 }
}

resource "aws_instance" "terra_ec2" {
    ami = "ami-062df10d14676e201"
    instance_type = "t2.micro"
    key_name = "ec2_key_pair"
    subnet_id = data.aws_subnet.get_subnet_id.id
    associate_public_ip_address = true
    availability_zone = "ap-south-1a"
    vpc_security_group_ids = [aws_security_group.terra_sg.id]
    root_block_device {
      volume_size = 20
      volume_type = "gp2"
      delete_on_termination = true
    }
    user_data = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install apache2 -y
        sudo systemctl enable apache2
        sudo systemctl start apache2
        EOF

    tags = {
      "Name" = "terra-ec2"
    }

}

# resource "aws_ebs_volume" "terra_ebs_volume" {
#   type = "gp2"  
#   size = 10
#   availability_zone = aws_instance.terra_ec2.availability_zone
#   tags = {
#     "Environment" = "DEV"
#   }
  
# }

# resource "aws_volume_attachment" "terra-volume-attachemnt" {
#   device_name = "/dev/sdh"
#   volume_id = aws_ebs_volume.terra_ebs_volume.id
#   instance_id = aws_instance.terra_ec2.id
# }

# resource "aws_cloudwatch_metric_alarm" "terra_alarm" {
#   alarm_name = "terra-ec2-alarm"
#   namespace = "AWS/EC2"
#   metric_name = "CPUUtilization"
#   dimensions = {
#     InstanceId = aws_instance.terra_ec2.id
#   }
#   statistic = "Average"
#   period = "120"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   threshold = "80"
#   alarm_actions = [aws_sns_topic.terra_sns_topic.arn]
#   evaluation_periods = "2"
  
# }

# resource "aws_sns_topic" "terra_sns_topic" {
#  name = "terra_sns_topic"
#  display_name = "testing"
 
# }

# resource "aws_sns_topic_subscription" "terra-sub" {
#   topic_arn = aws_sns_topic.terra_sns_topic.arn
#   protocol = "email"
#   endpoint = "suresh.akidev@gmail.com"
#   endpoint_auto_confirms = true
# }