#!/bin/bash 

#Author: Overacheivers | Catherine | catherinedhumphrey@gmail.com  
#06/19/22

##============>Creation and Configuration of Java and SonaQube<==============


#Double checking that the user is not root

if 
	[ $UID = 0 ]
then 
echo "Root user cannot run this script. Switch to another user to run script."
exit 1
fi

#Java Installation

echo "Updating yum. This process will take awhile. Please wait..."
sudo yum update -y 
sleep 3
echo "Installing Java..."
sudo yum install java-11-openjdk-devel -y 
sudo yum install java-11-openjdk -y
 
if [$? -ne 0 ]
then 
echo "Java failed to install. try again"
exit 2
fi

#Downloading lastest version of Sonaqube 

echo "Downloading the latest version of SonaQube"
sudo yum install wget -y
sudo yum install unzip -y
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip -P /opt
sudo unzip /opt/sonarqube-9.3.0.51899.zip -d /opt

#Changing ownership and switching to Linux binaries
sudo chown -R $USER:$USER /opt/sonarqube-9.3.0.51899
sudo sed -i 's/#RUN_AS_USER=/RUN_AS_USER=${USER}/g' /opt/sonarqube-9.3.0.51899/bin/linux-x86-64/sonar.sh
sudo chmod +x /opt/sonarqube-9.3.0.51899/bin/linux-x86-64/sonar.sh
/opt/sonarqube-9.3.0.51899/bin/linux-x86-64/sonar.sh start
/opt/sonarqube-9.3.0.51899/bin/linux-x86-64/sonar.sh status

#Adjusting firewall

sudo systemctl start firewalld
if 
	[ $? -ne 0 ]
then 
echo "Firewall failed start. Please try again."
exit 3
fi
sudo firewall-cmd --permanent --add-port=9000/tcp
sudo firewall-cmd --reload

#User directions 

ip a | grep 192 | awk '{print $2}'
echo "use the IP address to use for URL"
echo "Type as follows http://<IP_ADDRESS_ABOVE>:9000"
echo "SonaQube Installed. Thank You."
