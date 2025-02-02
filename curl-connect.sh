# the Authorization header value is base64 encoded ssologin:password. 

RESPONSE=$(kubectl exec -it connect-0 -n confluent -- \
  curl --location 'http://keycloak:8080/realms/sso_test/protocol/openid-connect/token' \
       --header 'Content-Type: application/x-www-form-urlencoded' \
       --header 'Authorization: Basic c3NvbG9naW46S2JMUmloMUh6akRDMjY3UGVmdUtVN1FJb1o4aGdIREs=' \
       --data-urlencode 'grant_type=client_credentials'
)
TOKEN=$(echo $RESPONSE | jq -r .access_token)

echo "Retrieved Token: $TOKEN"
  
CLUSTER_ID=a0c9a5f9-fdd2-4f5f-a33

kubectl exec -it connect-0 -n confluent -- \
  curl -k --location "https://connect:8083/connector-plugins" \
          --header "Content-Type: application/json" \
          --header "Accept: application/json" \
          --header "Authorization: Bearer $TOKEN" 
