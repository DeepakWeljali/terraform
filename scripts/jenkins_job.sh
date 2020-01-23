if [ ${provider} == aws ] 
then
   echo provider is ${provider}
   if [ ${act} == create ]
   then
     echo "Infra creation started"
     echo ${rds}
     exit 1
     sh scripts/setenv.sh
     sh scripts/infra.sh ${env} master
   else
     echo "Delete inprogress"
     cd templates
     terraform init
     terraform destroy -auto-approve
   fi
elif [ ${provider} == gcp ]
then
   echo provider is ${provider}
   cd ${env}
   terraform init
   terraform plan
   terraform apply -auto-approve
else
   echo provider is ${provider}
   cd ${env}
   terraform init
   terraform plan
   terraform apply -auto-approve
fi
