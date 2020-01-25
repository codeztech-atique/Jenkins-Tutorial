# install java 1.8 on Amazon Linux 
sudo yum update -y
sudo yum install -y java-1.8.0-openjdk-devel 
sudo alternatives --config java

# install Jenkins on Amazon Linux
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
sudo yum install jenkins

# ssh into EC2 instance (replace key name and hostname)  
ls -lah /path/jenkins-key.pem
chmod 400 /path/jenkins-key.pem
ssh -i /path/jenkins-key.pem ec2-user@ec2-123-456-78-9.compute-1.amazonaws.com  

# start Jenkins at boot time
sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service


#Restart Jenkins
sudo /etc/init.d/jenkins restart

# install git
sudo yum install git

#custom TCP 8080
#ssh will be 22
