for pod in kafka-0 kafka-1 kafka-2; do
  echo "Getting metrics from $pod"
  kubectl exec -it $pod -n confluent -- \
    curl localhost:7778 | grep ClusterLinkFetcher-0-strimzi-to-cp-.-Default | grep ConsumerLag
done
