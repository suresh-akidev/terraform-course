aws_region = "ap-south-1"
instance_count = 1
ingress_security_group = [ 
    {
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
        description = "ssh port"
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }
]

egress_security_group = [ 
    {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
        description = "outbound port"
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }
]

security_group_name = "terraform SG"
user_data_script = "apache-install.sh"
instance_name = "module-test-01"
key_name = "ec2_key_pair"
instance_type = "t3.micro"