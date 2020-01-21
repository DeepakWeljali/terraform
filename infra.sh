#Infra Deployment
#!/bin/bash
set -e
echo "### Infra deployment for the provided sdlc environment"

SDLC_ENVIRONMENT=$1
BRANCH=$2


if [[ "$#" -lt 2 ]]; then
  echo "Exiting: Pipeline parameters are missing. Cannot execute the pipeline"
  exit 1
fi

UTILITY_PATH='.'

cat <<EOF_code_params
SDLC_ENVIRONMENT=$SDLC_ENVIRONMENT
BRANCH=$BRANCH
EOF_code_params

# Check if we have the utility script and execute it
UTILITY_SCRIPT="${UTILITY_PATH}/utility_script.sh"
if [ ! -f "${UTILITY_SCRIPT}" ]; then
  echo "FATAL: ${UTILITY_SCRIPT} not found. Unable to include shared functions."
  exit 1
fi
. ${UTILITY_SCRIPT}

#Deployment
terraform init
#terraform plan
terraform plan \
  -var 'AWS_REGION=$AWS_REGION_NAME' 
  -var 'VPC_CIDR=$VPC_CIDR' 
  -var 'PUBLIC_SUBNET_CIDR=$PUBLIC_SUBNET_CIDR' 
  -var 'EGRESS_PROTOCOL=$EGRESS_PROTOCOL' 
  -var 'EGRESS_PORT=EGRESS_PORT' 
  -var 'EGRESS_CIDR=$EGRESS_CIDR' 
  -var 'INGRESS_PORT=$INGRESS_PORT' 
  -var 'INGRESS_PROTOCOL=$INGRESS_PROTOCOL' 
  -var 'INGRESS_CIDR=$INGRESS_CIDR' 
  -var 'AMI=$AMI_ID' 
  -var 'KEY_PATH=$KEY_PATH' 
  -auto-approve
