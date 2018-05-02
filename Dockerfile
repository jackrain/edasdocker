# raincloud
#
# VERSION               1.0
FROM registry.acs.aliyun.com/open/tomcat8.0.32:5.0.0

MAINTAINER alibabaforedas

WORKDIR /opt

RUN wget -q -O tomcat.tgz http://edas-public.oss-cn-hangzhou.aliyuncs.com/install_package/tomcat/taobao-tomcat-7.0.59.tgz

RUN rm -rf /acs/user/tomcat

RUN mkdir -p /acs/user/tomcat

RUN tar zxvf tomcat.tgz -C /acs/user/tomcat  --strip-components 1

RUN wget -q http://edas-public.oss-cn-hangzhou.aliyuncs.com/install_package/pandora/unauth/taobao-hsf.tgz

RUN tar zxvf taobao-hsf.tgz -C /acs/user/tomcat/deploy/

ENV JAVA_OPTS -Dpandora.location=/acs/user/tomcat/deploy/taobao-hsf.sar

WORKDIR /acs

RUN echo "raincloudedas setup"
# Create the pesudo log file to point to stdout
RUN ln -sf /dev/stdout /acs/user/tomcat/logs/catalina.out

# Expose the default port
EXPOSE 8080

ENTRYPOINT ["/acs/acsstart"]

RUN echo "raincloud run"
