provider "aws" {
  version = "~> 2.48"
  region = var.region
}
variable "region" {
  description = "The target region"
  default = "us-west-2"
}

resource "aws_s3_bucket" "example" {
  bucket = "testing-krishna"
  acl    = "private"
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
resource "aws_instance" "example_c" {
  ami = "ami-02701bcdc5509e57b"
  instance_type = "t2.micro"
  depends_on = [aws_s3_bucket.example]
}
