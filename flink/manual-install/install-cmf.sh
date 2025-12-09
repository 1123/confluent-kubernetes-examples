helm upgrade --install cmf confluentinc/confluent-manager-for-apache-flink  \
--version "~2.1.0" \
--namespace operator \
--set cmf.sql.production=false 
