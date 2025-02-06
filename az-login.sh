az login \
  --service-principal \
  -u $AZ_CLIENT_ID \
  -p $AZ_CLIENT_SECRET \
  --tenant $AZ_TENANT_ID

az aks get-credentials \
  --resource-group $AZ_RG --name $AKS_CLUSTER--overwrite-existing

