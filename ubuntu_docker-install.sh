#!/bin/bash 

echo "Run this script with a user that has sudo priviledges"
echo "press ctrl + c to stop script if sudo user isn't in use. 10 second countdown starts now."
sleep 15
## Clean system of old versions of Docker 
sudo apt-get remove docker docker-engine docker.io containerd runc

if 
[ $? -eq 0 ]
then 
echo "Success"
else 
echo "Apt could not remove old packages for reason(s) listed above, fix issue and try again"
fi

## Setting up the repository 

sudo apt-get update

if
[ $? -eq 0 ]
then
echo "Success!"
else 
echo "Apt failed to update system"
fi

## Installing certificates 

sudo apt-get install ca-certificates curl gnupg lsb-release

if
[ $? -eq 0 ]
then
echo "Success!"
else 
"Apt failed to install certificates"
fi

## Adding Docker's official GPG key 

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

if
[ $? -eq 0 ]
then
echo "Success!"
else 
"Failed to add Docker's official GPG key"
fi

## Setting up a stable repository 

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/kyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 

## Installing Docking Engine 
echo "updating apt-get..."
sudo apt-get update
sleep 3
echo ""
echo "installing docker..."
sudo apt-get install docker-ce docker-ce-cli containerd.io
sleep 3

## Checking status of Docker daemon 
echo "checking docker daemon status "
sudo systemctl status docker
sleep 3
echo "starting docker service"
sudo systemctl start docker
sleep 3
echo "enabling docker to start at reboot"
sudo systemctl enable docker 
sleep 3

## Verifying Docker installation 
echo "checking docker installation"
sudo docker run hello-world

if 
[ $? -eq 0 ]
then 
echo "Docker has been sucessfully installed!"
else 
echo "Docker has been unsuccessfully installed."
fi
