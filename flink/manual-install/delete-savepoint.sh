APP_NAME=basic-example
ENV=env1
SP_NAME=my-manual-savepoint-1
curl -H "Content-type: application/yaml" \
  -X DELETE http://localhost:8080/cmf/api/v1/environments/${ENV}/applications/${APP_NAME}/savepoints/${SP_NAME} 
