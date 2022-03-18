terraform {
  required_providers {
    aws = {
      version = ">= 2.4.0"
    }
  }

  required_version = ">= 1.0.10"
}

provider "aws" {
  region = var.zone_name
}

data "aws_vpc" "myvpcs" {
  default = true
}

data "aws_subnet_ids" "mysubnets" {
  vpc_id = data.aws_vpc.myvpcs.id
}

data "aws_subnet" "example" {
  for_each = data.aws_subnet_ids.mysubnets.ids
  id       = each.value
}

resource "aws_default_security_group" "mydefaultsg" {
  vpc_id = data.aws_vpc.myvpcs.id
}

resource "aws_instance" "my-web-01v" {
  ami                    = "ami-0e5b6b6a9f3db6db8"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  key_name               = "Oleg-user"
  user_data              = file("user_data.sh")
  tags = {
    Name  = "my-web-01v"
    owner = "Oleg Pavlov"
  }
}

resource "aws_security_group" "web-sg" {
  name        = "webserver-sg"
  description = "security group for my-web-01v"

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description = "bunch of TCP ports for webservers"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    description = "egress for my web server"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "my-sg"
    owner = "Oleg Pavlov"
  }
}
