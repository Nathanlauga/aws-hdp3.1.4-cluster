#!/bin/sh
# starting setup
sudo su
sudo apt update
sudo apt upgrade
sudo apt install python2.7 python python2.7-dev ntp selinux-utils

# ssh password less for ambari server
cd /root/.ssh/
echo "" > id_rsa.pub
cat id_rsa.pub >> authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

vi /etc/ssh/sshd_config
# AuthorizedKeysFile      /root/.ssh/authorized_keys      .ssh/authorized_keys

hostname -f
hostname <output previous cmd>
hostnamectl set-hostname 
vi /etc/cloud/cloud.cfg
    preserve_hostname: true

# config network
echo "172.31.12.173   ambari-server
172.31.9.130    name-node 
172.31.33.249   data-node1     
172.31.34.158   data-node2" >> /etc/hosts

update-rc.d ntp defaults
sudo ufw disable
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
setenforce 0
umask 0022

## install ubuntu 18 repo
cd
wget -O /etc/apt/sources.list.d/ambari.list  	http://public-repo-1.hortonworks.com/HDP/ubuntu18/3.x/updates/3.1.0.0/hdp.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
