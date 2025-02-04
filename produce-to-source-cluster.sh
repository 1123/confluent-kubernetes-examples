kubectl exec source-kafka-0 -n confluent -- \
  kafka-producer-perf-test \
    --topic demotopic \
    --producer-props bootstrap.servers=localhost:9092 \
    --num-records 100000 \
    --throughput 100000 \
    --record-size 10000
