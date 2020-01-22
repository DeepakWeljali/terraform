variable "ENV" {}
variable "INSTANCE_TYPE" {}
variable "PUBLIC_SUBNETS" {
  type = list
}
variable "VPC_ID" {}
variable "INGRESS_PORT" {}
variable "INGRESS_PROTOCOL" {}
variable "INGRESS_CIDR" {}
variable "EGRESS_PROTOCOL" {}
variable "EGRESS_PORT" {}
variable "EGRESS_CIDR" {}
variable "KEY_PATH" {
  default = "mykey.pub"
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.INSTANCE_TYPE

  # the VPC subnet
  subnet_id = element(var.PUBLIC_SUBNETS, 0)

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  tags = {
    Name         = "instance-${var.ENV}"
    Environmnent = var.ENV
  }
}

resource "aws_security_group" "allow-ssh" {
  vpc_id      = var.VPC_ID
  name        = "allow-ssh-${var.ENV}"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = var.EGRESS_PORT
    to_port     = var.EGRESS_PORT
    protocol    = var.EGRESS_PROTOCOL
    cidr_blocks = var.EGRESS_CIDR
  }

  ingress {
    from_port   = var.INGRESS_PORT
    to_port     = var.INGRESS_PORT
    protocol    = var.INGRESS_PROTOCOL
    cidr_blocks = var.INGRESS_CIDR
  }

  tags = {
    Name         = "allow-ssh"
    Environmnent = var.ENV
  }
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair-${var.ENV}"
  public_key = file("${path.root}/${var.KEY_PATH}")
}

