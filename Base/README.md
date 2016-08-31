#Building an IBM Data Server Manager Base image from binaries
 
An IBM Data Server Manager Base image can be built by obtaining the following binaries:

IBM Data Server Manager from [developerworks](http://www.ibm.com/developerworks/downloads/im/dsm/)


IBM Data Server Manager image is created by using the following Dockerfiles:

    Dockerfile

Dockerfile:

    1. Uses the image created by Dockerfile as the base image

    2. Copies the server startup script to the image

    3. When the container is started the server is started

Building the IBM Data Server Manager Base image

    1. Place the downloaded IBM Data Server Manager binaries and unpack to ibm-datasrvrmgr

    2. Edit setup.conf

    3. Place start_dsm.sh

    4. Download the ubuntu 14.04 image

```Bash
docker pull ubuntu:14.04
```

    5. Move to the directory base/

    6. Build the prereq image by using:

```Bash
docker build  -t <prereq-image-name> -f Dockerfile .
```
                            
Running the images

Using the IBM Data Server Manager Base traditional install image 
