resource "aws_instance" "test-innominds" {
  ami = "ami-02701bcdc5509e57b"
  instance_type = "t2.micro"
  key_name = "krishna-sand-1-4-2021"
  security_groups = [ "launch-wizard-15"]  
  tags = {
    Name = "Krishna-${terraform.workspace}"
  }
}

