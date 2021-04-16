provider "aws" {
  version = "~> 2.48"
  region = var.region
}
variable "region" {
  description = "The target region"
  default = "us-west-2"
}

resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "in_secondary_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "192.168.1.0/24"
}
