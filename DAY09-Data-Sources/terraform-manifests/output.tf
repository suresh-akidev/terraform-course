output "vpc_id" {
  value = data.aws_vpc.get_vpc_id.id
}

output "subnet_id" {
  value = data.aws_subnet.get_subnet_id.id
}