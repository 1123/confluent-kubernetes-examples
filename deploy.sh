#!/bin/bash

NAMESPACE=confluent

kubectl create namespace $NAMESPACE

kubectl config set-context --current --namespace=$NAMESPACE > /dev/null

kubectl apply \
  -f security/oauth/keycloak/keycloak_deploy.yaml

helm repo add confluentinc https://packages.confluent.io/helm

helm upgrade \
  --install operator confluentinc/confluent-for-kubernetes 

kubectl create secret generic oauth-jass \
  --from-file=oauth.txt=security/oauth/kraft/rbac/oauth_jass.txt

kubectl create secret tls ca-pair-sslcerts \
  --cert=assets/certs/generated/ca.pem \
  --key=assets/certs/generated/ca-key.pem

kubectl create secret generic mds-token \
  --from-file=mdsPublicKey.pem=assets/certs/mds-publickey.txt \
  --from-file=mdsTokenKeyPair.pem=assets/certs/mds-tokenkeypair.txt

kubectl apply -f security/oauth/kraft/rbac/cp_components.yaml

./curl-mds.sh || echo "MDS does not seem to be working"

kubectl apply -f restproxy.yaml

./curl-restproxy.sh || echo "Restproxy does not seem to be working"

kubectl apply -f connect.yaml

./curl-connect.sh || echo "Kafka Connect Cluster does not seem to be working"

kubectl apply -f schemaregistry.yaml

./curl-schemaregistry.sh || echo "Schema Registry does not seem to be working"

