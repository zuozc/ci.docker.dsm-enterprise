FROM ubuntu:14.04
MAINTAINER dsmdev@cn.ibm.com
WORKDIR /opt
ADD ibm-datasrvrmgr /opt/ibm-datasrvrmgr/
EXPOSE 11080 11081 11082
ADD start_dsm.sh /opt/
ENTRYPOINT ["/opt/start_dsm.sh"]
