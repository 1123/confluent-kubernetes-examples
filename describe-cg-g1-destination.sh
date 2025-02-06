kubectl cp destination.properties kafka-0:/tmp/destination.properties -n confluent
kubectl exec kafka-0 -n confluent -- \
  kafka-consumer-groups \
    --bootstrap-server kafka.confluent.svc.cluster.local:9071 \
    --describe --group g1 \
    --command-config /tmp/destination.properties

