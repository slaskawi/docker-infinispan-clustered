FROM jboss/infinispan-server

RUN chmod +x /opt/jboss/infinispan-server/bin/*.sh

# Turn off security
RUN sed -i 's/security-domain="other" auth-method="BASIC"//' /opt/jboss/infinispan-server/standalone/configuration/clustered.xml

CMD /opt/jboss/infinispan-server/bin/clustered.sh -b `ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'`