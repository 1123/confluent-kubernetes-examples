# Create a Kubernetes secret with the encryption key
kubectl create secret generic cmf-encryption-secret \
  --from-file=encryption-key=cmf.key \
  -n operator
