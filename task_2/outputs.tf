output "vpc_def_id" {
  value = data.aws_vpc.myvpcs.id
}


output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.example : s.cidr_block]
}

output "aws_security_group_id" {
  value = aws_default_security_group.mydefaultsg.id
}

output "aws_security_group_name" {
  value = aws_default_security_group.mydefaultsg.name
}

output "web_dns_name" {
  value = aws_instance.my-web-01v.public_dns
}
