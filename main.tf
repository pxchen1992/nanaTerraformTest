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

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_block

  azs             = [var.avali_zone]
  public_subnets  = [var.subnet_cidr_block]
  public_subnet_tags = { Name = "${var.env_prefix}-subnet-1"} 

  tags = {
   Name = "${var.env_prefix}-vpc"
  }
}

module "myapp-webserver" {
  source = "./modules/webserver"
   vpc_id = module.vpc.vpc_id
   my_ip = var.my_ip
   env_prefix = var.env_prefix
   public_key_location = var.public_key_location
   instance_type = var.instance_type
   subnet_id = module.vpc.public_subnets[0]
   avali_zone = var.avali_zone
}
