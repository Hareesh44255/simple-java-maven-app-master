#!/bin/sh

echo "called startup"
# apk add sudo
# addgroup -S dockergroup && adduser -S bob -G dockergroup
# adduser --disabled-password --gecos '' bob
# id -u bob
#sudo su
apk update
apk add sudo
apk add --update sudo

USER='bob'
adduser -D -S $USER && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER chmod 0440 /etc/sudoers.d/$USER
echo "called mid 1"
echo "User $(whoami) running from $PWD with premissions: $(sudo -l)"
cat /etc/passwd
sudo -lU $USER
adduser --disabled-password --gecos '' $USER
echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
adduser $USER wheel
sudo apk update
sudo -lU $USER
echo "called mid"
cat /etc/os-release

wget --quiet https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip
unzip -n terraform_0.11.3_linux_amd64.zip
pwd
ls -la
echo "KKKKKK $(whoami)"
adduser -D $USER
su -l $USER
echo "KKKKKK $(whoami)"
ls -l terraform

mv terraform /usr/bin

terraform --version
echo "called mid"
# echo "called mid"
ls -l terraform

#ls -l /usr/bin/terraform
echo "called mid"
# echo "called mid"

terraform
# terraform --version
# rm terraform_0.11.3_linux_amd64.zip
echo "called startup end"
# echo "called startup end"
