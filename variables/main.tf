provider "aws" {
  version = "~> 2.48"
  region = var.region
}
variable "region" {
  description = "The target region"
  default = "us-west-2"
}
variable "ami_id" {
  description = "The target region"
  type = string
  default = "ami-02701bcdc5509e57b"
}
resource "aws_instance" "web" {
  ami = var.ami_id
  instance_type = "t3.micro"
  key_name = "krishna-sand-1-4-2021"
  tags = {
    Name = "HelloWorld1"
  }
}
