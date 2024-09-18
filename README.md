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
