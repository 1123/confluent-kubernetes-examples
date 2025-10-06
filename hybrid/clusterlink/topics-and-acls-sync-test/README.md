## Testing ACL Migration with Cluster Linking

This example demonstrates how to use Cluster Linking to migrate Kafka ACLs from a source to a destination cluster. This setup uses SASL/PLAIN for authentication and does not use in-flight encryption (TLS).

## Set up Pre-requisites

Create two namespaces, one for the source cluster components and one for the destination cluster components.

```
kubectl create ns source
kubectl create ns destination
```

Deploy Confluent for Kubernetes (CFK) in cluster mode, so that the one CFK instance can manage Confluent deployments in multiple namespaces. Here, CFK is deployed to the `default` namespace.

```
helm upgrade --install confluent-operator \
  confluentinc/confluent-for-kubernetes \
  --namespace default --set namespaced=false
```

### Create required secrets

```
kubectl -n source create secret generic credential \
    --from-file=plain-users.json=creds-kafka-sasl-users.json \
    --from-file=plain.txt=creds-client-kafka-sasl-user.txt \
    --from-file=basic.txt=creds-basic-users.txt

kubectl -n destination create secret generic credential \
    --from-file=plain-users.json=creds-kafka-sasl-users.json \
    --from-file=plain.txt=creds-client-kafka-sasl-user.txt \
    --from-file=basic.txt=creds-basic-users.txt
```

### Source Cluster Deployment

Deploy source zookeeper, kafka cluster and topic `demo` in namespace `source`.

```
kubectl apply -f zk-kafka-source.yaml
```

### Destination Cluster Deployment

Deploy destination zookeeper and kafka cluster in namespace `destination`.

```
kubectl apply -f zk-kafka-destination.yaml
```

### Create ClusterLink

After the Kafka clusters are in a running state, create a cluster link between source and destination. The cluster link will be created in the destination cluster.

```
kubectl apply -f clusterlink.yaml
```

### Run test

#### Create ACLs on the source cluster

Create a Kubernetes Job to create the ACLs on the source cluster.

```
kubectl apply -f create-acl-job.yaml
```

Verify that the job has completed successfully.

```
kubectl get job create-kafka-acl-job -n source -o wide
```

Check the logs of the job to confirm that the ACLs were created.

```
kubectl logs job/create-kafka-acl-job -n source
```

#### Verify ACL migration on the destination cluster

Exec into the destination kafka pod.

```
kubectl -n destination exec kafka-0 -it -- bash
```

Create a `client.properties` file to connect to the Kafka cluster.

```
cat <<EOF > /tmp/client.properties
security.protocol=SASL_PLAINTEXT
sasl.mechanism=PLAIN
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="kafka" password="kafka-secret";
EOF
```

List the ACLs on the destination cluster and verify that the ACLs created on the source cluster have been migrated.

```
kafka-acls --bootstrap-server kafka.destination.svc.cluster.local:9096 --list --command-config /tmp/client.properties
```

#### Verify message replication

Exec into the source kafka pod.

```
kubectl -n source exec kafka-0 -it -- bash
```

Create a `client.properties` file to connect to the Kafka cluster.

```
cat <<EOF > /tmp/client.properties
security.protocol=SASL_PLAINTEXT
sasl.mechanism=PLAIN
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username=\"kafka\" password=\"kafka-secret\";
EOF
```

Produce some messages to the `demo` topic.

```
seq 100 | kafka-console-producer --broker-list kafka.source.svc.cluster.local:9096 --topic demo --producer.config /tmp/client.properties
```

Open a new terminal and exec into the destination kafka pod.

```
kubectl -n destination exec kafka-0 -it -- bash
```

Create a `client.properties` file to connect to the Kafka cluster.

```
cat <<EOF > /tmp/client.properties
security.protocol=SASL_PLAINTEXT
sasl.mechanism=PLAIN
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username=\"kafka\" password=\"kafka-secret\";
EOF
```

Consume messages from the `demo` topic and verify that the messages are replicated.

```
kafka-console-consumer --bootstrap-server kafka.destination.svc.cluster.local:9096 --topic demo --from-beginning --consumer.config /tmp/client.properties
```

## Tear Down

```
kubectl delete -f clusterlink.yaml
kubectl delete -f zk-kafka-destination.yaml
kubectl delete -f zk-kafka-source.yaml
kubectl -n source delete secret credential
kubectl -n destination delete secret credential
kubectl delete ns source
kubectl delete ns destination
```
