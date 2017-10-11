FROM quay.io/cloudian/centos-ssh:7-jdk8
ENV SBVER=3.1.0-RC5
ENV ANTVER=1.9.9
ENV FBVER=3.0.1

RUN yum install -y git

ADD apache-ant-1.9.9-bin.tar.gz /usr/local/
ADD findbugs-3.0.1.tar.gz /usr/local/
ADD spotbugs-${SBVER}.tgz /usr/local/
ADD sudoers /etc/sudoers.d/

RUN (ln -s /usr/local/apache-ant-${ANTVER} /usr/local/ant; \
     ln -s /usr/local/apache-ant-${ANTVER} /usr/java/ant; \
     ln -s /usr/local/findbugs-${FBVER}/ /usr/share/; \
     ln -s /usr/local/findbugs-${FBVER} /usr/share/findbugs; \
     ln -s /usr/share/findbugs/bin/findbugs /usr/local/bin/; \
     ln -s /usr/local/spotbugs-${SBVER}/ /usr/share/; \
     ln -s /usr/local/spotbugs-${SBVER} /usr/share/spotbugs; \
     ln -s /usr/local/spotbugs-${SBVER} /usr/local/spotbugs; \
     ln -s /usr/local/spotbugs-${SBVER}/bin/spotbugs /usr/local/bin/; \
     ln -s /usr/local/spotbugs/lib/spotbugs-ant.jar /usr/java/ant/lib/; \
     sed -i '/grant *{/a permission javax.management.MBeanTrustPermission "register";' /usr/java/default/jre/lib/security/java.policy)

ADD ant-findbugs.jar /usr/local/ant/lib

##########################################################################
# worker
RUN (useradd -u 1000 worker; echo "worker:password" | chpasswd; \
     mkdir -p /var/log/cloudian; chown worker:worker /var/log/cloudian)

ADD bashrc /home/worker/.bashrc


EXPOSE 22
CMD ["/sbin/init"]
