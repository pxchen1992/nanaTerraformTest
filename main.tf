provider "aws" {
    region = ap-southeast-2
}

#resource "<provider>_<resourceType>" "name we can define" {
#each resource block describes one or more infrastructure objects

variable vpc_cidr_block {}
variable subnet_cidr_block {}
variable avali_zone {}
variable env_prefix {}

resource "aws_vpc" "myapp-vpc" {
    cidr_block = var.vpc_cidr_blocks
    tag = {
        Name: "${var.env_prefix}-vpc"
    }
}

resource "aws_subnet" "myapp-subnet-1" {
  vpc_id = aws_vpc.myapp-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avali_zone
  tags = {
    Name: "${var.env_prefix}-subnet-1"
  }
}
