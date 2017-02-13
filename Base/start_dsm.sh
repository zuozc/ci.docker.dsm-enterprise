#!/bin/bash

if [ -d /opt/ibm-datasrvrmgr/Config ]; then
  echo "INFO: Old config file exists, will run upgrade on dsm with existing config file"
  if [ `ls /opt/ibm-datasrvrmgr/logs | wc -l` -gt 0 ]; then
     echo "INFO: Old logs file exists, will run upgrade on dsm with existing logs file"
  else
     echo "INFO: Old logs file does exist, will run upgrade on dsm with empty logs file"
  fi 
  mkdir -p /opt/ibm-datasrvrmgr/dscomponents_with_rep
  mkdir -p /opt/ibm-datasrvrmgr/dscomponents
  mkdir -p /opt/ibm-datasrvrmgr/java
  mkdir -p /opt/ibm-datasrvrmgr/license
else
  echo "INFO: Old config file does not exist, setup a new dsm service"
fi
echo "INFO: Setup dsm..."
sh /opt/ibm-datasrvrmgr/setup.sh -silent
echo "INFO: Stop dsm..."
sh /opt/ibm-datasrvrmgr/bin/stop.sh
echo "INFO: Restart dsm..."
/opt/ibm-datasrvrmgr/bin/server-startup.sh start
