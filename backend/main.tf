provider "aws" {
  version = "~> 2.48"
  region = var.region
}
variable "region" {
  description = "The target region"
  default = "us-west-2"
}

terraform {
  required_version = "= 0.12.20"
  backend "s3" {
    bucket = "es-sandbox-test"
    key    = "innominds/test/terraform.tfstate"
    region = "us-west-2"
  }
}

resource "aws_instance" "web" {
  ami = "ami-02701bcdc5509e57b"
  instance_type = "t3.micro"
  key_name = "krishna-sand-1-4-2021"
  tags = {
    Name = "HelloWorld1"
  }
}

output "instance_ip_addr" {
  value = aws_instance.web.private_ip
}
