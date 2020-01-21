variable "ENV" {
}

variable "AWS_REGION" {
}

variable "PUBLIC_SUBNET_CIDR" { 
type = list
}

variable "PRIVATE_SUBNET_CIDR" {
type = list
}

variable "VPC_CIDR" { 
type = string
}


module "main-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${var.ENV}"
  cidr = "${var.VPC_CIDR}"

  azs             = ["${var.AWS_REGION}a", "${var.AWS_REGION}b", "${var.AWS_REGION}c"]
  private_subnets = "${var.PRIVATE_SUBNET_CIDR}"
  public_subnets  = "${var.PUBLIC_SUBNET_CIDR}"

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.ENV
  }
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.main-vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.main-vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.main-vpc.public_subnets
}

