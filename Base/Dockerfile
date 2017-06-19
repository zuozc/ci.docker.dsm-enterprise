FROM centos:7
MAINTAINER dsmdev@cn.ibm.com
WORKDIR /opt
ADD ibm-datasrvrmgr /opt/ibm-datasrvrmgr/
EXPOSE 11080 11081 11082
ADD start_dsm.sh /opt/
RUN yum update -y
RUN yum install which -y
RUN chmod +x /opt/start_dsm.sh
ENTRYPOINT ["/opt/start_dsm.sh"]
