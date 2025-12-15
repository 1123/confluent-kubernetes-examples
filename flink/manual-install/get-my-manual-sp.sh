APP_NAME=basic-example
ENV=env1
curl -s -H "Content-type: application/yaml" \
  -X GET http://localhost:8080/cmf/api/v1/environments/${ENV}/applications/${APP_NAME}/savepoints/my-manual-savepoint-1 \
