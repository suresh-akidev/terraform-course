locals {
    ports = [80,443,8080,8081]
}

resource "aws_security_group" "sg-dynamic" {
  name        = "demo-regular"
  description = "demo-regular"

  dynamic "ingress" {
    for_each = local.ports
    content {
        description = "description ${ingress.key}"
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

  }
}