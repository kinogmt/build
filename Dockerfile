FROM quay.io/cloudian/centos-ssh:7.9.2009
ENV SBVER=4.2.3
ENV ANTVER=1.9.9
ENV FBVER=3.0.1
ENV JAVA_HOME=/usr/lib/jvm/java

RUN yum install -y git maven python3-pip zip java-11-openjdk-devel ncurses-devel gcc-c++ rpm-build
RUN pip3 install pip --upgrade
RUN pip3 install awscli --upgrade

ADD apache-ant-1.9.9-bin.tar.gz /usr/local/
ADD findbugs-3.0.1.tar.gz /usr/local/
ADD spotbugs-${SBVER}.tgz /usr/local/
ADD sudoers /etc/sudoers.d/

RUN (ln -s /usr/local/apache-ant-${ANTVER} /usr/local/ant; \
     ln -s /usr/local/apache-ant-${ANTVER} ${JAVA_HOME}/ant; \
     ln -s /usr/local/findbugs-${FBVER}/ /usr/share/; \
     ln -s /usr/local/findbugs-${FBVER} /usr/share/findbugs; \
     ln -s /usr/share/findbugs/bin/findbugs /usr/local/bin/; \
     ln -s /usr/local/spotbugs-${SBVER}/ /usr/share/; \
     ln -s /usr/local/spotbugs-${SBVER} /usr/share/spotbugs; \
     ln -s /usr/local/spotbugs-${SBVER} /usr/local/spotbugs; \
     ln -s /usr/local/spotbugs-${SBVER}/bin/spotbugs /usr/local/bin/; \
     ln -s /usr/local/spotbugs/lib/spotbugs-ant.jar ${JAVA_HOME}/ant/lib/; \
     sed -i '/grant *{/a permission javax.management.MBeanTrustPermission "register";' ${JAVA_HOME}/jre/lib/security/java.policy)

ADD ant-findbugs.jar /usr/local/ant/lib

##########################################################################
# worker
RUN (useradd -u 1000 worker; echo "worker:password" | chpasswd; \
     mkdir -p /var/log/cloudian; chown worker:worker /var/log/cloudian)

ADD bashrc /home/worker/.bashrc

########
# golang
########
RUN (GOL=go1.16.3.linux-amd64.tar.gz; \
     curl -O curl -O https://dl.google.com/go/${GOL}; \
     rm -rf /usr/local/go && tar -C /usr/local -xzf ${GOL}; \
     ln -sf /usr/local/go/bin/go /usr/bin/go; \
     go get github.com/tebeka/go2xunit; \
     su - worker -c "go get github.com/tebeka/go2xunit"; \
     rm -f ${GOL})


EXPOSE 22
CMD ["/sbin/init"]
