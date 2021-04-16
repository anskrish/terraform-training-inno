provider "aws" {
  version = "~> 2.48"
  region = var.region
}
variable "region" {
  description = "The target region"
  default = "us-west-2"
}
variable "tags" {
  description = "Tags for the resource"
  type = map(string)
  default = {
    Contact = "Krishna Rudraraju"
    Company = "Innominds"
    Practice = "DevOps"
    Role = "DevOps"
}
}
resource "aws_instance" "web" {
  ami = "ami-013f17f36f8b1fefb"
  instance_type = "t2.micro"
  key_name = "test-krishna"
  tags = {
    Name = "krishna-import"
  }
}
