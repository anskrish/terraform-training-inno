provider "aws" {
  version = "~> 2.48"
  region = var.region
}

variable "region" {
  description = "The target region"
  default = "us-west-2"
}

data "aws_vpc" "selected" {
  id = "vpc-0e9e9d6f5174388c3"
}

resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.selected.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}
