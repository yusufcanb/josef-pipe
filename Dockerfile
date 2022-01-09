FROM jenkins/jenkins:lts-jdk11

USER root
RUN apt-get update && apt-get install -y python3 python3-pip python3-dev

# Ansible configuration
COPY ansible /opt/ansible
RUN python3 -m pip install -r /opt/ansible/requirements.txt

# Robot Framework configuration
COPY robots /opt/robots
RUN python3 -m pip install -r /opt/robots/requirements.txt

# Jenkins configuration
USER jenkins

COPY dsl /opt/deploy/dsl

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false -Dhudson.model.DirectoryBrowserSupport.CSP=
ENV JENKINS_OPTS --argumentsRealm.roles.user=admin --argumentsRealm.passwd.admin=admin --argumentsRealm.roles.admin=admin

COPY --chown=jenkins:jenkins jenkins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY jenkins/casc.yaml /var/jenkins_home/casc.yaml
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

ENV JENKINS_ADMIN_ID admin
ENV JENKINS_ADMIN_PASSWORD=admin
