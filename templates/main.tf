terraform {
  backend "s3" {
    bucket = "psl-terraform"
    key = datafoundry
    region = "us-east-1"
  }
}


module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = var.ENV
  AWS_REGION = var.AWS_REGION
  PUBLIC_SUBNET_CIDR = var.PUBLIC_SUBNET_CIDR
  PRIVATE_SUBNET_CIDR = var.PRIVATE_SUBNET_CIDR
  VPC_CIDR = var.VPC_CIDR
}

module "instances" {
  source         = "../modules/instances"
  ENV            = var.ENV
  VPC_ID         = module.main-vpc.vpc_id
  PUBLIC_SUBNETS = module.main-vpc.public_subnets
  INGRESS_PORT = var.INGRESS_PORT
  INGRESS_PROTOCOL = var.INGRESS_PROTOCOL
  INGRESS_CIDR = var.INGRESS_CIDR
  EGRESS_PORT = var.EGRESS_PORT
  EGRESS_PROTOCOL = var.EGRESS_PROTOCOL
  EGRESS_CIDR = var.EGRESS_CIDR
  INSTANCE_TYPE = var.INSTANCE_TYPE
  AMI_ID = var.AMI_ID
  KEY_PATH = var.KEY_PATH
}

