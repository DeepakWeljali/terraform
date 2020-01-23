#!/bin/bash
#
# This should be included by each script to DRY things up.
#
SDLC_ENVIRONMENT=$1
echo ' -- Utility functions and shared variables included.'

###################
# Global settings
# Functions
function fatal(){
  echo "FATAL: $1"
  exit 1
}

function set_environment(){
  case "$SDLC_ENVIRONMENT" in
    "stg"|"prod")
      [ -z "$AWS_REGION" ] && AWS_REGION='us-east-1'
      AWS_REGION_NAME='UsEast1'
      ACCOUNT_NAME="data-foundry"
      ACCOUNT_NUMBER="6542456899"
      VPC_CIDR="10.0.0.0/16"
      PUBLIC_SUBNET_CIDR='["10.0.1.0/28"]'
      EGRESS_PROTOCOL="-1"
      EGRESS_PORT="0"
      EGRESS_CIDR='["0.0.0.0/0"]'
      INGRESS_PORT="22"
      INGRESS_PROTOCOL="tcp"
      INGRESS_CIDR='["0.0.0.0/0"]'
      INSTANCE_TYPE="t2.micro"
      AMI_ID="ami-4fffc834"
      KEY_PATH="mykey.pub"
      ;;
    *)
      [ -z "$AWS_REGION" ] && AWS_REGION='us-east-1'
      AWS_REGION_NAME='UsEast1'
      ACCOUNT_NAME="data-foundry"
      ACCOUNT_NUMBER="6542456899"
      VPC_CIDR="10.0.0.0/16"
      PUBLIC_SUBNET_CIDR='["10.0.1.0/28"]'
      EGRESS_PROTOCOL="-1"
      EGRESS_PORT="0"
      EGRESS_CIDR='["0.0.0.0/0"]'
      INGRESS_PORT="22"
      INGRESS_PROTOCOL="tcp"
      INGRESS_CIDR='["0.0.0.0/0"]'
      INSTANCE_TYPE="t2.micro"
      AMI_ID="ami-4fffc834"
      KEY_PATH="mykey.pub"
      ;;
  esac
}

echo "Calling set environment"
set_environment


cat <<EOF_set_environment
 Environment settings:
      ACCOUNT_NAME=$ACCOUNT_NAME
      ACCOUNT_NUMBER=$ACCOUNT_NUMBER
      AWS_REGION=$AWS_REGION
      VPC_CIDR=$VPC_CIDR
      PUBLIC_SUBNET_CIDR=$PUBLIC_SUBNET_CIDR
      EGRESS_PROTOCOL=$EGRESS_PROTOCOL
      EGRESS_PORT=$EGRESS_PORT
      EGRESS_CIDR=$EGRESS_CIDR
      INGRESS_PORT=$INGRESS_PORT
      INGRESS_PROTOCOL=$INGRESS_PROTOCOL
      INGRESS_CIDR=$INGRESS_CIDR
      AMI_ID=$AMI_ID
      KEY_PATH=$KEY_PATH
      RDS=$RDS
EOF_set_environment
