#!/bin/bash
sh /opt/ibm-datasrvrmgr/setup.sh -silent
sh /opt/ibm-datasrvrmgr/bin/stop.sh
/opt/ibm-datasrvrmgr/bin/server-startup.sh start
