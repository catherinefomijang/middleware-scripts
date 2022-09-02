#!/bin/zsh

#Author: Catherine F. | catheriendhumphrey@gmail.com
#Date: 9/2/22
#Description: Zsh script for Terraform installation as well as auto-completion for terraform commands with the tab key on CentOs machines 

##Installation of "yum-config-manager" with yum-utils. For managing repos.
sudo yum install -y yum-utils

if 
[ $? -eq 0 ]
else 
echo "yum failed to install yum utilites"
fi

##Add HashiCorp Linux repo.
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

if 
[ $? -eq 0 ]
else 
echo "yum-config-manager failed to add HashiCorp Linux repository"
fi

##Install Terraform from the new repo

sudo yum -y install terraform

if 
[ $? -eq 0 ]
else 
echo "Terraform installation failed. Read error and try again."
fi

##Verify Terraform's Installation on machine 

terraform -help > /dev/null

if 
[ $? -eq 0 ]
then 
echo "Terraform has been successfully installed!"
else 
echo "Terraform installation failed. Read error and try again."
fi

##Enable tab completion for zsh. Creating config file for zsh.

touch ~/.zshrc

if 
[ $? -eq 0 ]
else 
echo "Configuration file failed to create."
fi

##Install the autocomplete package.

terraform -install-autocomplete

if 
[ $? -eq 0 ]
else 
echo "Autocomplete package installation failed."
fi