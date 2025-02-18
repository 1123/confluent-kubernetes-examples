kubectl exec source-kafka-0 -n confluent -- \
  kafka-console-consumer \
    --topic demotopic \
    --bootstrap-server localhost:9092 \
    --consumer-property group.id=g1 \
    --consumer-property auto.commit.interval.ms=100 \
    --max-messages 10
