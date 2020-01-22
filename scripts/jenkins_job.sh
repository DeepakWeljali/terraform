if [ ${provider} == aws ] 
then
   echo provider is ${provider}
   pwd
   sh scripts/setenv.sh
   sh scripts/infra.sh ${env} master
elif [ ${provider} == gcp ]
then
   echo provider is ${provider}
   pwd
   cd ${env}
   terraform init
   terraform plan
   terraform apply -auto-approve
else
   echo provider is ${provider}
   pwd
   cd ${env}
   terraform init
   terraform plan
   terraform apply -auto-approve
fi
