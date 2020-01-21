variable "ENV"{
  default = "dev"
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "VPC_CIDR" {
  type = string
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "PUBLIC_SUBNET_CIDR"  {
  type = list
  description = "CIDR for the public subnet"
  default     = ["0.0.1.0/24"]
}

variable "PRIVATE_SUBNET_CIDR" {
  type = list
  description = "CIDR for the private subnet"
  default     = ["10.0.2.0/24"]
}

variable "EGRESS_PORT" {
  description = "Port for egress rules"
  default     = "0"
}

variable "EGRESS_PROTOCOL" {
  description = "Protocol for egress rules"
  default     = "-1"
}


variable "EGRESS_CIDR" {
  type = list
  description = "CIDR for the egress rules"
  default     = ["0.0.0.0/0"]
}

variable "INGRESS_PORT" {
  type = number
  description = "Port for ingress rules"
  default     = "22"
}

variable "INGRESS_PROTOCOL" {
  type = string
  description = "Protocol for ingress rules"
  default     = "tcp"
}

variable "INGRESS_CIDR" {
  type = list
  description = "CIDR for the ingress rules"
  default     = ["0.0.0.0/0"]
}

variable "AMI" {
  type = string
  description = "AMI for EC2"
  default     = "ami-4fffc834"
}

variable "KEY_PATH" {
  type = string
  description = "SSH Public Key path"
  default     = "mykey.pub"
}
