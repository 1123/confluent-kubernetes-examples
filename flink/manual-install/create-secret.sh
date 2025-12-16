kubectl create secret generic gcp-app-creds \
  --from-file=gcp_creds.json \
  --namespace=operator
