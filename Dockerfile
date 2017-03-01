FROM quay.io/cloudian/centos-ssh:jdk8

RUN yum install -y git

ADD apache-ant-1.9.9-bin.tar.gz /usr/local/
ADD findbugs-3.0.1.tar.gz /usr/local/
ADD sudoers /etc/sudoers.d/

RUN (ln -s /usr/local/apache-ant-1.9.9 /usr/local/ant; \
     ln -s /usr/local/findbugs-3.0.1/ /usr/share/; \
     ln -s /usr/local/findbugs-3.0.1 /usr/share/findbugs; \
     sed -i '/grant *{/a permission javax.management.MBeanTrustPermission "register";' /usr/java/default/jre/lib/security/java.policy)

ADD ant-findbugs.jar /usr/local/ant/lib

##########################################################################
# worker
RUN (useradd -u 1000 worker; echo "worker:password" | chpasswd; \
     mkdir -p /var/log/cloudian; chown worker:worker /var/log/cloudian)

ADD bashrc /home/worker/.bashrc


EXPOSE 22
CMD service crond start; /usr/sbin/sshd -D
