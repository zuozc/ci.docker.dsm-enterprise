#Building an IBM Data Server Manager Base image from binaries
 
An IBM Data Server Manager Base image can be built by obtaining the following binaries:

IBM Data Server Manager from [developerworks](http://www.ibm.com/developerworks/downloads/im/dsm/)


IBM Data Server Manager image is created by using the following Dockerfiles:

    Dockerfile

Dockerfile:

    1. Uses the image created by Dockerfile as the base image

    2. Copies the server startup script to the image

    3. When the container is started the server is started

Building the IBM Data Server Manager image

    1. Move to the directory Base/
    
    2. Place the downloaded IBM Data Server Manager binaries into Base/ and unpack to ibm-datasrvrmgr

    3. Build the image by using:

```Bash
docker build  -t <image-name> -f Dockerfile .
```
                            
Run and Deploy IBM Data Server Manager image and expose port 11080&11081

    1. Mount nothing: this will create a clean DSM container
    
```Bash
docker run -itd -p 11080:11080 -p 11081:11081 <image-name>
```
	
    2. Mount Config files and logs: this will create a DSM container using config files and logs specified
    
```Bash
docker run -itd -p 11080:11080 -p 11081:11081 -v <config-folder>:/opt/ibm-datasrvrmgr/Config -v <log-folder>:/opt/ibm-datasrvrmgr/logs <image-name>
```

e.g. Suppose you've cloned this project into "/opt/ci.docker.dsm-enterprise", your old dsm container is called "dsm" and your new DSM image is called "dsm_image". You can:

    2.1 Externalize the logs and configs from the old container:
    
```Bash
docker exec -it dsm bash
scp -r /opt/ibm-datasrvrmgr/Config root@<host-ip>:/opt/ci.docker.dsm-enterprise/Base/example
scp -r /opt/ibm-datasrvrmgr/logs root@<host-ip>:/opt/ci.docker.dsm-enterprise/Base/example
```

    2.2 Mount logs and configs back to a new container:

```Bash
docker run -itd -p 11080:11080 -v /opt/ci.docker.dsm-enterprise/Base/example/Config:/opt/ibm-datasrvrmgr/Config -v /opt/ci.docker.dsm-enterprise/Base/example/logs:/opt/ibm-datasrvrmgr/logs <image-name> 
```
    3. Set default user and repository database: you can set default user profile and repository databases by env vars.

```Bash
docker run -itd -p 11080:11080 -p 11081:11081 -e DSM_ADMIN=<admin user name> -e DSM_ADMIN_PWD=<admin password> -e DSM_REPODB_IP=<RepoDB IP address> -e DSM_REPODB_PORT=<RepoDB port> -e DSM_REPODB_USER=<RepoDB user name> -e DSM_REPODB_PWD=<RepoDB password> -e DSM_REPODB_NAME=<RepoDB name> <image-name>
``` 

