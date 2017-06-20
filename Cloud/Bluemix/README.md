#Deploy Data Server Manager on Cloud


##Upload docker image to Bluemix Container service
 
1.    Install CLI plugins and login
Firstly, you need to install CLI command on your system. You can refer to https://new-console.ng.bluemix.net/docs/containers/container_cli_cfic_install.html
 
1.1   Install docker
For Windows and OS X operating systems, Docker is installed along with the Docker Toolbox, which includes the Docker Machine, Docker Engine, and Kitematic. For Linux operating systems, installation mechanisms vary depending on the type of Linux distribution you use.

1.2   Install Cloud Foundry CLI 
Install Cloud Foundry CLI version 6.14.0 - 6.16.0 from the GitHub repository. You must install the Cloud Foundry CLI in the default location for your operating system, otherwise the PATH environment variable does not match your installation directory. 
To verify that the Cloud Foundry CLI is installed properly or, if you already installed the Cloud Foundry CLI, to check which version you installed, run the following command:
```Bash 
cf -v
```
1.3   Install CLI container plugin

 
Install the IBM® Containers plug-in (cf ic) to run native Docker CLI commands to manage your containers. Please refer to previous link. For example, on Linux 64bit run this command:
 
cf install-plugin https://static-ice.ng.bluemix.net/ibm-containers-linux_x64 

1.4  Login to Bluemix
```Bash
cf login -a api.ng.bluemix.net
```
Input your IBM ID and password and select organization and space.
Then login to ic plug-in:
```Bash
cf ic login
```
Set the namespace for your organization if this is the first time a user has logged in to your organization.
```Bash
cf ic namespace set <new_name>
```
If you do not know your organization's namespace, you can run cf ic namespace get after running cf ic login.

2     Add image to private repository

This part describes how to upload image to Bluemix. You can refer to https://new-console.ng.bluemix.net/docs/containers/container_images_copying.html.

2.1    Copy the image

You can copy an image into your organization's private Bluemix® repository from Docker hub, Bluemix or your private Bluemix repository.
cf ic cpi test/dsm registry.ng.bluemix.net/my_namespace/my_dsm

2.2    Verify the image
 Verify that the image exists in your repository by running the images command.
```Bash
cf ic images
```
3    Create container based on DSM image 
Now you can create your container from the image you upload

The provided shell script simplified the process:
```Bash
./uploadConImg.sh ng.bluemix.net dw_dsm dsmv21 dsm.tar dsmv21
```
or
```Bash
./uploadConImg.sh ng.bluemix.net dw_dsm dsmv21 <imageID>
```
