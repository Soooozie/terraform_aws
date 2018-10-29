#!/bin/bash

sudo su

apt update -y

apt upgrade -y

apt install python3 -y

apt install python-pip -y

pip install awscli

mkdir ~/.aws

cp /vagrant/.credentials ~/.aws/credentials

apt install unzip -y

cd /vagrant 

wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip

unzip terraform_*

rm -f terraform_*

echo "export PATH=\"\$PATH:/vagrant\"" >> /vagrant/.bashrc

cd /usr/bin

ln -s /vagrant/terraform terraform

cd /vagrant

source /vagrant/.bashrc

terraform init
