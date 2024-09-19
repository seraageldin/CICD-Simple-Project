## CICD-Simple-Project steps using freestyle 

## Simple CI/CD project using Docker file and HTML index file for deployment 

## The first Step is installing Jenkins on your machine, however, we need to install Java first too
find all the steps for installing Jenkins for different OS on the installing-Jenkins file in this repo

## After opening the Jenkins we need to install plugins

then we will need to create jobs 
we will create 3 Jobs 
1- Job for Code-clone
2- Job for Build
3- Job for Deploy

## Make sure the docker file has the image 
FROM httpd
COPY index.html /usr/local/apache2/htdocs   // you can get any other image but our base image will be httpd

## You need to make a clone from this repo to your machine using 
git clone + repo URL 

## Step 1

create a job for code clone type freestyle
inside the job configuration click on git

then you will clone the repo http from GitHub by copying the HTTP
paste it in the git field
make sure the branch name is correct ( since you will be working on a branch from this repo enter the branch name )

build type will Pull SCM
H/5 * * * *  ( this means that Jenkins will check for updates every 5 minutes only if there is any change on the repo )

add timestamps of the job in the build environment
in post build action you can select the option to send you an email after the build is complete
save job 

## Step 2
if you ls /var/lib/jenkins/workspace
you will check the jobs in a dir called workspaces that has all run jobs it will empty before any build 

now the job shall work and be success 
if you cd in the workshop you will find the first job name code clone and if you cd inside it you will get the repo fields listed here in GitHub

create job number 2 

name the job build and freestyle

go to build options 
add timestamp
select write shell script execute shell
we have to be in the Jenkins home directory so we will write the shell script below

cd ${JENKINS_HOME}/workspace/code-clone/CICD-Simple-Project // we are using Jenkins variables 
sudo docker build -t project_image:${BUILD_NUMBER} .
echo " The Build is Done "

## Step 3 

create the third job 
deploy-docker
add timestamp
execute a shell in build steps
note that during every build we will need to keep the port number the same so we will need to delete the old container

sudo docker volume create vol_1 //You can add a volume if you need the data to be kept when the container is deleted and deployed on the new container 
sudo docker rm cont_${BUILD_NUMBER}
sudo docker run -d --name cont_${BUILD_NUMBER} -p 80:80 -v vol_1:/usr/local/apache2 project_image:${BUILD_NUMBER}
// note that with each new build number, we need to delete the old container in order to keep using the same port 
save job

## Important steps to link jobs 

go to code clone job configurations
post build action 
build other projects
select the build job and save

this means when the clone is finished build job will be called to start

then go to build job configuration
post build action 
select job docker_deploy and save

if you go to your system and check the docker images you won't find the image that we will create and there should be no container 
once you edit anything in the repo code or add a file the cd/cd will run

You can open 3 tabs of Jenkins for each job and watch them execute automatically when the time comes after you edit the repo

The best approach is to configure passwordless sudo for the Jenkins user, so sudo commands do not require a password during automation. Here’s how to do it

to overwrite the data in the volume for the old container 
docker cp /var/lib/jenkins/workspace/project-w-pipeline/index.html cont_1:/usr/local/apache2/htdocs/index.html 
note that you need to stop the container and run it again 
docker stop cont_1 
docker start cont_1

hence you will see the new index file displayed to your website

sudo visudo
Add the following line at the end of the file
jenkins ALL=(ALL) NOPASSWD: ALL

## Ensure the below
make sure of any syntax error Dockerfile, not dockerfile
ensure the user is sudoers unless you can use sudo in the script 
you can use the ifconfig 
and then get teh docker IP
after all jobs are succeded you can open the localhost:80 to view the website from your browser 
and then put it in the browser and you can see your landing page 
you can go and make any update in the index.html on your machine and commit it to the repo branch and it will reflect your website after jenkins reads it 
