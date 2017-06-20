This directory contains how to deploy DSM docker image in different Cloud platforms.

There may be requiement in Cloud to add database connection into DSM automatically after monitored database instance created.
There is 2 method to do this:
1. Inside the DSM container:
```Bash
/opt/ibm-datasrvrmgr/dsutil/bin/upddbprofile.sh -dbProfile "${Profile_name}" \
-dataServerType DB2LUW -host ${db2_ip}  -port ${db2_port} -databaseName ${db_name} \
-user ${db2_user} -password ${db2_password}
```                        
2. Outside the DSM container:
```Bash
curl -u ${dsm user} -p -u ${dsm password}  https://${DSM_IP}:${DSM_PORT}/console/dbmgt/dbmgr.do \
--data {"name":"${Profile_name}","dataServerExternalType":"DB2LUW","databaseName":"${db_name}",\
"host":"${db2_ip}","port":${db2_port},"securityMechanism":"3","user":"${db2_user}",\
"password":"${db2_password}","creator":"${dsm user}","JDBCProperties":"","xtraProps":"","comment":"",\
"URL":"jdbc:db2://${db2_ip}:${db2_port}/${db_name}:retrieveMessagesFromServerOnGetMessage=true;securityMechanism=3;",\
"dataServerType":"DB2LUW"}  
```
