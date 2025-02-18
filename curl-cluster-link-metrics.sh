for pod in kafka-0 kafka-1 kafka-2; do
  echo "Getting metrics from $pod"
  kubectl exec -it $pod -n confluent -- \
    curl localhost:7778 | grep kafka_server_link_clusterlinkfetchermanager_value
done
