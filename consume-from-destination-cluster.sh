kubectl exec kafka-0 -n confluent -- \
  kafka-console-consumer \
    --topic demotopic \
    --bootstrap-server kafka.confluent.svc.cluster.local:9071 \
    --consumer-property group.id=g1 \
    --consumer-property commit.interval.ms=10 \
    --consumer-property sasl.mechanism=PLAIN \
    --consumer-property security.protocol=SASL_SSL \
    --consumer-property ssl.truststore.location=/mnt/sslcerts/truststore.jks \
    --consumer-property ssl.truststore.password=mystorepassword \
    --max-messages 10 \
    --consumer-property "sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username=kafka password=kafka-secret;" \
    --from-beginning
