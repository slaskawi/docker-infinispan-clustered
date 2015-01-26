FROM jboss/infinispan-server

# ISPN 8080 8181 9990 11211 11222
# Jolokia 7777
EXPOSE 8080 8181 9990 11211 11222 7777

# Turn off security
RUN chmod +x /opt/jboss/infinispan-server/bin/*.sh
RUN /opt/jboss/infinispan-server/bin/add-user.sh -u ispnadmin -p ispnadmin -r ManagementRealm -e -s
RUN sed -i 's/security-domain="other" auth-method="BASIC"//' /opt/jboss/infinispan-server/standalone/configuration/clustered.xml

# Download jolokia JVM agent for Hawt.io
RUN mkdir -p /opt/jboss/jolokia
RUN curl http://labs.consol.de/maven/repository/org/jolokia/jolokia-jvm/1.2.3/jolokia-jvm-1.2.3-agent.jar > /opt/jboss/jolokia/jolokia-agent.jar

# 1. Run clustered
# 2. Wait until jboss modules starts
# 3. Run Jolokia
CMD /opt/jboss/infinispan-server/bin/clustered.sh \
	-b `ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'` \
	-bmanagement `ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'` &\
	sleep 10s;\
	java -jar /opt/jboss/jolokia/jolokia-agent.jar \
		--host `ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}'` \
		--port 7777 \
		".*jboss.modules.*";\
	tail -f /opt/jboss/infinispan-server/standalone/log/server.log