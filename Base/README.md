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

    1. Place the downloaded IBM Data Server Manager binaries and unpack to ibm-datasrvrmgr

    2. Edit setup.conf
    
    NOTE: To change the default password to login DSM
	    2.1. RUN .\dsutil\bin\crypt.bat on Windows; RUN .\dsutil\bin\crypt.sh on Linux
	    2.2. ENTER new password twice and you will get a crypt string for your password
	    2.3. EDIT setup.conf file, and REPLACE "XXXXXXXXX" in "admin.password=XXXXXXXXX" with your crypt string
	    2.4. SAVE this file
     
    3. Place start_dsm.sh

    4. Download the ubuntu 16.04 image

```Bash
docker pull ubuntu:16.04
```

    5. Move to the directory base/

    6. Build the image by using:

```Bash
docker build  -t <image-name> -f Dockerfile .
```
                            
Run and Deploy IBM Data Server Manager image and expose port 11080

    1. Mount nothing: this will create a clean DSM container
    
```Bash
docker run -itd -p 11080:11080 <image-name>
```
	
    2. Mount Config files and logs: this will create a DSM container using config files and logs specified
    
```Bash
docker run -itd -p 11080:11080 -v <config-folder>:/opt/ibm-datasrvrmgr/Config -v <log-folder>:/opt/ibm-datasrvrmgr/logs <image-name>
```

e.g. Suppose you've clone this project into "/opt/ci.docker.dsm-enterprise" and your image is called "dsm". You can run:

	docker run -itd -p 11080:11080 -v /opt/ci.docker.dsm-enterprise/Base/example/Config:/opt/ibm-datasrvrmgr/Config -v /opt/ci.docker.dsm-enterprise/Base/example/logs:/opt/ibm-datasrvrmgr/logs dsm


