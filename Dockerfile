# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
FROM payara/server-full:5.194

COPY --chown=payara:payara target/payara-clientcert-test-0.9-SNAPSHOT.war ${DEPLOY_DIR}
COPY --chown=payara:payara bin/pre-boot-commands.asadmin ${PREBOOT_COMMANDS}
COPY --chown=payara:payara bin/post-boot-commands.asadmin ${POSTBOOT_COMMANDS}
