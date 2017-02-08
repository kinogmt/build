FROM quay.io/cloudian/centos-ssh:jdk8

RUN yum install -y git

ADD apache-ant-1.9.9-bin.tar.gz /usr/local/
ADD findbugs-3.0.1.tar.gz /usr/local/
ADD sudoers /etc/sudoers.d/

RUN ln -s /usr/local/apache-ant-1.9.9 /usr/local/ant

##########################################################################
# worker
RUN (useradd worker; echo "worker:password" | chpasswd)

ADD bashrc /home/worker/.bashrc


EXPOSE 22
CMD service crond start; /usr/sbin/sshd -D
