# CICD-Simple-Project
Simple CI/CD project using Docker file and HTML index file for deployment 

First Step installing Jenkins on your machine, however we need to install Java first

for Ubuntu machine use the below commands

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
sudo apt install -y jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

Access jenkins server using the following URL http:localhost:8080

for RedHat and Centos machines

create the jENKINS REPO
add its official repository to your system

Create a new repo file for Jenkins in /etc/yum.repos.d/

sudo tee /etc/yum.repos.d/jenkins.repo <<EOF
[jenkins]
name=Jenkins-stable
baseurl=http://pkg.jenkins.io/redhat-stable
gpgcheck=1
gpgkey=https://pkg.jenkins.io/redhat-stable/jenkins.io.key
EOF

Import the Jenkins GPG key

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key


curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo

sed -i 's/gpgcheck=1/gpgcheck=0/' /etc/yum.repos.d/jenkins.repo

dnf update -y 
sudo dnf install -y java-17-openjdk
sudo dnf install -y jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins

sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload

Access jenkins server using the following URL http:localhost:8080

Login into jenkins 
use the below password fro th ementioned path

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

after opening the jenkins we need to install plugins

then we will need to create jobs 
make sure docker file has teh image 
FROM httpd
COPY index.html /usr/local/apache2/htdocs

1- create job for code clone type free style
then you will clone the repo http from github by copying the HTTP
paste it in the git field
make sure teh branch name is correct ( default - main )
build type will by Pull SCM
H/5 * * * *  
the above means pull every 5 minutes 
add timestamps of the job in build environment
in post build action you can select option to send you an email after build is complete
save job 

if you ls /var/lib/jenkins/workspace
you will check the jobs in a dir called workspaces that has all run jobs

now teh job shall work and is sucess 
if you cd in the workshop you will find the first job name code clone and if you cd inside it you will get the repo fiels listed here in github

create job number 2 

name the job build and freestyle

go to build options 
add time stamp
select write shell script execute shell
we have to be in the jenkins home directory so we will write the shell script as below

cd ${JENKINS_HOME}/workspace/code-clone/
sudo docker build -t project_image:${BUILD_NUMBER} .
echo " The Build is Done "

create third job 
deploy-docker
add timestamp
execute shell in build steps
note that during every build we will need to keep the port number the same so we will need to delete the old container

docker volume create vol_1
docker run -d --name cont_1 -p 80:80 -v vol_1:/usr/local/apache2 project_image:${BUILD_NUMBER}

save job

go to code clone job configurations
post build action 
build other projects
select build job and save

this means when clone is finished build job will be called to start

go to build job configuration
post build action 
select docker_deploy and save

if you go to your system and check docker images you wont find the image that will we create and there should be no container 
once you edit anything in the repo code or add a file the cd/cd will run

youy can open 3 tabs of jenkisn for each job and watch them execute automatically when the time comes after you edit the repo





