provider "aws" {
  version = "~> 2.48"
  region = var.region
}
variable "region" {
  description = "The target region"
  default = "us-west-2"
}

resource "aws_s3_bucket" "test" {
  bucket = "internal-innominds"
  acl = "private"
}
resource "aws_s3_bucket" "test" {
  bucket = "external-innominds"
  acl = "public-read"
}
resource "aws_s3_bucket" "test" {
  for_each = {
    internal = "private"
    external = "public-read"
   }
  bucket = "${each.key}-innominds"
  acl = each.value
}

