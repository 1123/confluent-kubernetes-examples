kubectl exec source-kafka-0 -n confluent -- \
  kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group g1
