FROM quay.io/cloudian/centos-ssh:7-jdk8
ENV SBVER=3.1.0-RC5

RUN yum install -y git maven python2-pip

ADD apache-ant-1.9.9-bin.tar.gz /usr/local/
ADD findbugs-3.0.1.tar.gz /usr/local/
ADD spotbugs-${SBVER}.tgz /usr/local/
ADD sudoers /etc/sudoers.d/

RUN (ln -s /usr/local/apache-ant-1.9.9 /usr/local/ant; \
     ln -s /usr/local/findbugs-3.0.1/ /usr/share/; \
     ln -s /usr/local/findbugs-3.0.1 /usr/share/findbugs; \
     ln -s /usr/share/findbugs/bin/findbugs /usr/local/bin/; \
     ln -s /usr/local/spotbugs-${SBVER}/ /usr/share/; \
     ln -s /usr/local/spotbugs-${SBVER} /usr/share/spotbugs; \
     ln -s /usr/share/spotbugs-${SBVER}/bin/spotbugs /usr/local/bin/; \
     sed -i '/grant *{/a permission javax.management.MBeanTrustPermission "register";' /usr/java/default/jre/lib/security/java.policy)

ADD ant-findbugs.jar /usr/local/ant/lib

##########################################################################
# worker
RUN (useradd -u 1000 worker; echo "worker:password" | chpasswd; \
     mkdir -p /var/log/cloudian; chown worker:worker /var/log/cloudian)

ADD bashrc /home/worker/.bashrc


EXPOSE 22
CMD ["/sbin/init"]
