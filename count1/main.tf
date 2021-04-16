
provider "aws" {
  version = "~> 2.48"
  region = var.region
}
variable "region" {
  description = "The target region"
  default = "us-west-2"
}

variable "test" {
  description = "The target region"
  type = bool
  default = true
}
resource "aws_instance" "web" {
  count = var.test ? 1 : 0
  ami = "ami-02701bcdc5509e57b"
  instance_type = "t3.micro"
  key_name = "krishna-sand-1-4-2021"
  tags = {
    Name = "HelloWorld1"
  }
}


