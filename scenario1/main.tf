provider "aws" {
  version = "~> 2.48"
  region = var.region
}
variable "region" {
  description = "The target region"
  default = "us-east-1"
}
variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "10.0.2.0/24"
}

resource "aws_vpc" "main" {
  cidr_block  = "10.0.0.0/16"
  tags = {
    Name = "myterraform-vpc"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "linoxide gw"
  }
}


resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "us-east-1a"

  tags = {
  Name = "Linoxide Public Subnet"
  }
}


resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "us-east-1a"

  tags = {
  Name = "Linoxide Private Subnet"
  }
}

resource "aws_route_table" "public-subnet" {
  vpc_id = aws_vpc.main.id

  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.default.id
}

  tags = {
  Name = "Linoxide Public Subnet"
}
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-subnet.id
}

resource "aws_security_group" "web" {
  name = "vpc_web"
  description = "Accept incoming connections."

  ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"] 
  }
  vpc_id = aws_vpc.main.id

  tags = {
  Name = "WebServerSG"
  }
}

resource "aws_instance" "web-1" {
  for_each = {
    private = aws_subnet.private-subnet.id
    public = aws_subnet.public-subnet.id
   }
  ami = "ami-013f17f36f8b1fefb"
  availability_zone = "us-east-1a"
  instance_type = "t2.small"
  vpc_security_group_ids = ["${aws_security_group.web.id}"] 
  subnet_id = each.value
  tags = {
    Name = "${each.key}-Instance"
  }
}
