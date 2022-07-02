#!/bin/bash

#Author : Catherine F. 
#Date : 06/12/22
#Revisied on 6/18/22

##------------Description : Jenkins installation script -------------------


# Installing java 
sudo yum install java-1.8.0-openjdk-devel -y
if 
    [ $? -ne 0 ]
then 
echo "Java was not successfully installed. Please try again."
exit 1
fi
echo ""
echo ""
sleep 1
# Enabling the Jenkins repository 
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
if 
    [ $? -ne 0 ]
then 
echo "Jenkins reposity failed to enable."
exit 2
fi 
echo ""
sleep 1
# Disabling the key check on repository
sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo
if 
    [ $? -ne 0 ]
then    
echo "Key check failed to disable. Please try again."
exit 3
fi
echo ""
sleep 1
# Installing the last version of Jenkins
sudo yum install jenkins -y
if 
    [ $? -ne 0 ]
then 
echo "Jenkins installation failed. Please try again."
exit 4
fi
echo ""
echo ""
sleep 2
sudo systemctl start jenkins
if 
    [ $? -ne 0 ]
then 
echo "System could not start Jenkins"
exit 5
else 
sudo systemctl status jenkins
fi
echo""
sleep 2
# Enabling Jenkins to start on system reboot 
sudo systemctl enable jenkins
if 
    [ $? -ne 0 ]
then 
echo "Jenkins failed to enable start on system reboot"
exit 6
fi
echo ""
sleep 1
# Adjusting firewall
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp 
if 
    [ $? -ne 0 ]
then 
echo "Port '8080' failed to be added"
exit 7
fi
sudo firewall-cmd --reload
if 
    [ $? -ne 0 ]
then 
echo "Firewall failled to reload"
exit 8
fi
echo ""
echo ""
echo ""
sleep 3
# Administrator password that is to be copied and then pasted into 'Unlock Jenkins'

echo "Copy and paste this 32 digit password into the 'Unlock Jenkins' page"
echo ""
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo ""
echo ""
sleep 3

# Instructions for user when Jenkins is installed 

echo "When prompted to customize plug-ins for Jenkins, select 'install suggested plugins'."
echo ""
echo ""
sleep 3
echo "For first admin user, type 'utrains' for username, 'school1' for password, and 'your@email' for email"
echo ""
echo ""
sleep 3
echo "Now click 'Save and Finish' for the instance configuration page"
echo ""
echo ""
echo ""
sleep 3
echo "---------------------------------------------------"
sleep 1
echo "Process Complete!"
