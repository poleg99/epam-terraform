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
