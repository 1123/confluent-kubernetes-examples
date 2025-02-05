kubectl exec source-kafka-0 -n confluent -- \
  kafka-console-consumer \
    --topic demotopic \
    --bootstrap-server localhost:9092 \
    --consumer-property group.id=g4 
