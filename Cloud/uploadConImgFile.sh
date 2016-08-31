#!/bin/bash
# $1: bluemix endpoint $2: namespace $3: imageName $4: imageFile $5: bluemix user
if [ $# -lt 4 ]; then
 echo "uploadConImage bluemix_endpoint namespace imageName imageFile"
 exit
fi
blueEP=$1
namespace=$2
imageName=$3
imageFile=$4
#install docker
docker_cmd=`command -v docker`
if [ -z "$docker_cmd" ]; then
echo "install docker ...."
apt-get install docker.io
fi

#install cf command
cf_cmd=`command -v cf`
if [ -z "$cf_cmd" ]; then
echo "install cf command ..."
rpm -ivh cf-cli-installer_6.20.0_x86-64.rpm
fi

#install cf ic plugin
cf_ic_cmd=`cf plugins|grep IBM-Containers`
if [ -z "$cf_ic_cmd" ]; then
#echo "remove containers plugin..."
#cf uninstall-plugin IBM-Containers
echo "install cf container plugin..."
while true; do
cf install-plugin https://static-ice.ng.bluemix.net/ibm-containers-linux_x64
if [ $? == 0 ]; then
   break
fi
done  
fi
echo "login to Bluemix..."
cf login -a api.$blueEP
echo "login to IBM containers..."
while true; do
cf ic login
if [ $? == 0 ]; then
   break
fi
done
echo "import dsm image to local registry..."
#docker load -i $imageFile
imageID=`docker images |grep "dsm-enterprise" |awk '{print $3}'`
echo "upload dsm image to Bluemix docker hub..."
docker tag  -f $imageID  registry.$blueEP/$namespace/$imageName:v1
while true; do
docker push  registry.$blueEP/$namespace/$imageName:v1
if [ $? == 0 ]; then
   break
fi
cf ic login

done


