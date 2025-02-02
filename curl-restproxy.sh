# Make sure to port-forward key-cloak first, to get the token
# the Authorization header value is base64 encoded ssologin:password. 
# also add the following to /etc/hosts:
#
# 127.0.0.1	kafka
# 127.0.0.1	keycloak

RESPONSE=$(kubectl exec -it kafkarestproxy-0 -n confluent -- \
  curl --location 'http://keycloak:8080/realms/sso_test/protocol/openid-connect/token' \
       --header 'Content-Type: application/x-www-form-urlencoded' \
       --header 'Authorization: Basic c3NvbG9naW46S2JMUmloMUh6akRDMjY3UGVmdUtVN1FJb1o4aGdIREs=' \
       --data-urlencode 'grant_type=client_credentials'
)
TOKEN=$(echo $RESPONSE | jq -r .access_token)

# echo "Retrieved Token: $TOKEN"
  
# Make sure to also port-forward rest-proxy
kubectl exec -it kafkarestproxy-0 -n confluent -- \
  curl -k --location "https://kafkarestproxy:8082/topics" \
   --header "Content-Type: application/vnd.kafka.v2+json" \
   --header "Accept: application/vnd.kafka.v2+json" \
   --header "Authorization: Bearer $TOKEN" 
