curl \
  --location 'http://localhost:8080/realms/sso_test/protocol/openid-connect/token' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --header 'Authorization: Basic c3NvbG9naW46S2JMUmloMUh6akRDMjY3UGVmdUtVN1FJb1o4aGdIREs=' \
  --data-urlencode 'grant_type=client_credentials'
