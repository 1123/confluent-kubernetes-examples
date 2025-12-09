helm upgrade --install cp-flink-kubernetes-operator --version "~1.130.0" \
  confluentinc/flink-kubernetes-operator \
  --set watchNamespaces="{operator}" \
  --namespace operator
