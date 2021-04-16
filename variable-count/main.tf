provider "aws" {
  version = "~> 2.48"
  region = var.region
}
variable "region" {
  description = "The target region"
  default = "us-west-2"
}
variable "port" {
  description = "The target region"
  type = number
  default = 443
}
variable "cidr" {
  description = "The target region"
  type = list
  default = ["0.0.0.0/0","10.0.0.0/16"]
}

variable "test" {
  description = "The target region"
  type = bool
  default = true
}
resource "aws_security_group" "My_VPC_Security_Group" {
  count = var.test ? 1 : 0
  vpc_id       = "vpc-2d3bd94b"
  name         = "test-ssl-1"
  description  = "My VPC Security Group"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.cidr
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
  } 
  
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
