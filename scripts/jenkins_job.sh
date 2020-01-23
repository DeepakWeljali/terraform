if [ ${provider} == aws ] 
then
   echo provider is ${provider}
   if [ ${act} == create ]
   then
     echo "Delete inprogress"
     sh scripts/setenv.sh
     sh scripts/infra.sh ${env} master
   else
     cd templates
     terraform destroy
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
