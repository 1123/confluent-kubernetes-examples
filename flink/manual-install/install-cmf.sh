helm upgrade --install cmf --version "~2.1.0" \
  confluentinc/confluent-manager-for-apache-flink \
  --namespace operator \
  --set encryption.key.kubernetesSecretName=cmf-encryption-secret \
  --set encryption.key.kubernetesSecretProperty=encryption-key \
  --set cmf.sql.production=true
