#!/bin/bash

NAMESPACE=confluent

kubectl create namespace $NAMESPACE

kubectl config set-context \
  --current \
   --namespace=$NAMESPACE

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

