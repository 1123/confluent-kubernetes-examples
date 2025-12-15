APP_NAME=basic-example
ENV=env1
curl -H "Content-type: application/yaml" \
  -X POST http://localhost:8080/cmf/api/v1/environments/${ENV}/applications/${APP_NAME}/savepoints \
  -d '{
  "apiVersion": "cmf.confluent.io/v1",
  "kind": "Savepoint",
  "metadata": {
    "name": "my-manual-savepoint-1"
  },
  "spec": {
    "path": "s3://benedikt-flink-savepoints/flink-savepoints",
    "formatType": "CANONICAL",
    "backoffLimit": 0
  }
}'
