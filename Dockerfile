FROM registry.redhat.io/rhdm-7/rhdm-kieserver-rhel8
ENV JBOSS_HOME /opt/eap
ENV JBOSS_CONFIG $JBOSS_HOME/standalone/configuration
ENV JBOSS_BIN $JBOSS_HOME/bin
ENV M2 $HOME/.m2
ENV MAVEN_REPO $M2/repository
COPY etc/settings.xml $M2
COPY etc/application-roles.properties $JBOSS_CONFIG/application-roles.properties
COPY etc/application-users.properties $JBOSS_CONFIG/application-users.properties
COPY etc/mgmt-groups.properties $$JBOSS_CONFIG/mgmt-groups.properties
COPY etc/mgmt-users.properties $JBOSS_CONFIG/mgmt-users.properties
COPY etc/standalone-full.xml $JBOSS_CONFIG/standalone.xml
COPY etc/standalone.sh $JBOSS_BIN/standalone.sh
USER root
RUN chown jboss:root $JBOSS_BIN/standalone.sh
RUN chown jboss:root $JBOSS_CONFIG/standalone.xml
RUN chown jboss:root $JBOSS_CONFIG/application-roles.properties
RUN chown jboss:root $JBOSS_CONFIG/application-users.properties
USER jboss
#EXPOSE 9990 9999 8080 8001
EXPOSE 8080
ENTRYPOINT ["/opt/eap/bin/standalone.sh"]
#CMD ["-c","standalone.xml","-b","0.0.0.0","-bmanagement","0.0.0.0"]
CMD ["-c","standalone.xml","-b","0.0.0.0"]
#It gives a 401 error if the port is not 8080
#rest server at localhost:8080/services/rest/server