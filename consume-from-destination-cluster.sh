kubectl exec kafka-0 -n confluent -- \
  kafka-console-consumer \
    --topic demotopic \
    --bootstrap-server localhost:9092 \
    --consumer-property group.id=g1 \
    --consumer-property commit.interval.ms=10 \
    --from-beginning


sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username='kafka' password='kafka-secret';
sasl.mechanism=PLAIN
security.protocol=SASL_SSL
ssl.truststore.location=/mnt/sslcerts/truststore.jks
ssl.truststore.password=confluent
