set -u -e

echo "Logging in to Azure"
az login \
   --service-principal \
   -u $AZ_CLIENT_ID \
   -p $AZ_CLIENT_SECRET \
   --tenant $AZ_TENANT_ID > /dev/null

echo "Getting credentials for Kubernetes Cluster"
az aks get-credentials \
               --resource-group $AZ_RG \
               --name $AKS_CLUSTER \
               --overwrite-existing > /dev/null 2>&1

echo "Setting subscription"
az account set --subscription $AZ_SUBSCRIPTION_ID 
