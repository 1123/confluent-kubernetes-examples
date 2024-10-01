kubectl create secret generic tls-group1 \
--from-file=fullchain.pem=generated/server.pem \
--from-file=cacerts.pem=generated/cacerts.pem \
--from-file=privkey.pem=generated/server-key.pem 
