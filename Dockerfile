FROM quay.io/cloudian/centos-ssh:jdk8

RUN yum install -y git

ADD apache-ant-1.9.9-bin.tar.gz /tmp/
ADD findbugs-3.0.1.tar.gz /tmp/

##########################################################################
# worker
RUN (useradd worker; echo "worker:password" | chpasswd)

EXPOSE 22
CMD service crond start; /usr/sbin/sshd -D
