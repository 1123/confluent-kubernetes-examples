kubectl create secret generic kafka-tls \
--from-file=fullchain.pem=server.pem \
--from-file=cacerts.pem=ca.pem \
--from-file=privkey.pem=server-key.pem
