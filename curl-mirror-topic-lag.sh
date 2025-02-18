kubectl exec -it kafka-0 -n confluent -- \
  curl localhost:7778 | grep kafka_server_cluster_link_metrics_mirror_topic_lag
