This repository is set up to demostrate a possible bug in Payara server 5.194. Client certificate authentication does not work correctly if the default realm "certificate" is used.

Steps to reproduce: 

1. Build to war file

2. Build the docker image: sudo docker build -t payara-clientcert-test .

3. Run the docker image: sudo docker run --rm -p 8181:8181 --name pt payara-clientcert-test

4. Step into the container: sudo docker exec -it pt /bin/bash

5. In the container, create a pkcs12 file: keytool -importkeystore -srckeystore appserver/glassfish/domains/production/config/keystore.jks -destkeystore export.p12 -deststoretype PKCS12 -srcalias s1as -deststorepass changeit

6. Exit the container

7. Copy the key off the container: sudo docker cp pt:/opt/payara/export.p12 .

8. Run: curl -v -k --cert-type P12 --cert export.p12:changeit https://localhost:8181/admins/resources/javaee8
    and enjoy the 403

9. In JAXRSConfiguration.java make one change in one annotation: @CertificateIdentityStoreDefinition(value = "certificate2", assignGroups = "admin")

10. Repeat steps 2, 3, 8. This time it works and returns the 200 OK. 

