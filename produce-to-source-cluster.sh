kubectl exec source-kafka-0 -n confluent -- \
  kafka-producer-perf-test \
    --topic demotopic \
    --producer-props bootstrap.servers=localhost:9092 \
    --num-records 1000000 \
    --throughput 1 \
    --record-size 10
