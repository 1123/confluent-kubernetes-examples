ACR_NAME=benediktubuntudev
az acr build --registry $ACR_NAME --image flink-sample-app:0.0.4 --file ./Dockerfile .
