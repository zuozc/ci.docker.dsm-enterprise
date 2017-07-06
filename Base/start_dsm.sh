#!/bin/bash
if [ -z "$DSM_ADMIN" ]; then
  echo ""
  echo 'DSM_ADMIN not set'
  echo 'Use default user: admin'
  DSM_ADMIN=admin
fi

if [ -z "$DSM_ADMIN_PWD" ]; then
  echo ""
  echo  'DSM_ADMIN_PWD not set'
  echo  "Use default password: password"
  DSM_ADMIN_PWD=password
fi

if [ ! -f /opt/ibm-datasrvrmgr/setup.conf ]; then
  echo ""
  echo >&2 'Error: no setup.conf file'
  echo >&2 'Make sure ibm-datasrvrmgr is in the same directory as the docker file'
  exit 1
fi

sed -i 's/#product.license.accepted=y/product.license.accepted=y/' /opt/ibm-datasrvrmgr/setup.conf
sed -i "s/#admin.user=admin/admin.user=$DSM_ADMIN/" /opt/ibm-datasrvrmgr/setup.conf
DSM_ADMIN_PWD_ENC="$(/opt/ibm-datasrvrmgr/dsutil/bin/crypt.sh "$DSM_ADMIN_PWD")"
sed -i "s/#admin.password=<encrypted password>/admin.password=$DSM_ADMIN_PWD_ENC/" /opt/ibm-datasrvrmgr/setup.conf


if [[ -z "$DSM_REPODB_IP" || -z "$DSM_REPODB_PORT" || -z "$DSM_REPODB_NAME" || -z "$DSM_REPODB_USER" || -z "$DSM_REPODB_PWD" ]]; then
  echo ""
  echo  'Rrepository vars not fully set '
  echo  "Won't config repositoryDB"
else
  # Repository db setup
  sed -i "s/#repositoryDB.dataServerType=DB2LUW/repositoryDB.dataServerType=DB2LUW/" /opt/ibm-datasrvrmgr/setup.conf
  sed -i "s/#repositoryDB.host=mydbserver.mydomain.com/repositoryDB.host=${DSM_REPODB_IP}/" /opt/ibm-datasrvrmgr/setup.conf
  sed -i "s/#repositoryDB.port=50000/repositoryDB.port=${DSM_REPODB_PORT}/" /opt/ibm-datasrvrmgr/setup.conf
  sed -i "s/#repositoryDB.databaseName=REPODB/repositoryDB.databaseName=${DSM_REPODB_NAME}/" /opt/ibm-datasrvrmgr/setup.conf
  sed -i "s/#repositoryDB.user=DB2ADMIN/repositoryDB.user=${DSM_REPODB_USER}/" /opt/ibm-datasrvrmgr/setup.conf

  DSM_REPODB_PWD_ENC="$(/opt/ibm-datasrvrmgr/dsutil/bin/crypt.sh "${DSM_REPODB_PWD}")"
  sed -i "s/#repositoryDB.password=<encrypted password>/repositoryDB.password=${DSM_REPODB_PWD_ENC}/" /opt/ibm-datasrvrmgr/setup.conf
  sed -i "s/#repositoryDB.securityMechanism=9/repositoryDB.securityMechanism=9/" /opt/ibm-datasrvrmgr/setup.conf
fi

if [ -d /opt/ibm-datasrvrmgr/Config ]; then
  echo "Old config file exists, will run upgrade on dsm with existing config file"
  if [ `ls /opt/ibm-datasrvrmgr/logs | wc -l` -gt 0 ]; then
     echo "Old logs file exists, will run upgrade on dsm with existing logs file"
  else
     echo "Old logs file does exist, will run upgrade on dsm with empty logs file"
  fi 
  mkdir -p /opt/ibm-datasrvrmgr/dscomponents_with_rep
  mkdir -p /opt/ibm-datasrvrmgr/dscomponents
  mkdir -p /opt/ibm-datasrvrmgr/java
  mkdir -p /opt/ibm-datasrvrmgr/license
else
  echo "Old config file does not exist, setup a new dsm service"
fi

sh /opt/ibm-datasrvrmgr/setup.sh -silent

while true; do
  sleep 1
done


