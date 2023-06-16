provider "aws" {
  region = "ap-southeast-2"
}

#resource "<provider>_<resourceType>" "name we can define" {
#each resource block describes one or more infrastructure objects


resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name : "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source = "./modules/subnet"
  subnet_cidr_block = var.subnet_cidr_block
  avali_zone = var.avali_zone
  env_prefix = var.env_prefix
  vpc_id = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}

module "myapp-webserver" {
  source = "./modules/webserver"
   vpc_id = aws_vpc.myapp-vpc.id
   my_ip = var.my_ip
   env_prefix = var.env_prefix
   public_key_location = var.public_key_location
   instance_type = var.instance_type
   subnet_id = module.myapp-subnet.subnet.id
   avali_zone = var.avali_zone
}
