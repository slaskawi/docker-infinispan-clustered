FROM jboss/infinispan-server

# ISPN 8080 8181 9990 11211 11222
EXPOSE 8080 8181 9990 11211 11222

# Turn off security
RUN chmod +x /opt/jboss/infinispan-server/bin/*.sh
RUN /opt/jboss/infinispan-server/bin/add-user.sh -u ispnadmin -p ispnadmin -r ManagementRealm -e -s
RUN sed -i 's/security-domain="other" auth-method="BASIC"//' /opt/jboss/infinispan-server/standalone/configuration/clustered.xml

CMD /opt/jboss/infinispan-server/bin/clustered.sh \
	-b `ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'` \
	-bmanagement `ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'`