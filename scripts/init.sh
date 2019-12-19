#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'You need to set the current machine hostname (it has to be the same as the one into /var/hosts) as argument! 
    Example : ./init.sh ambari-server `'
    exit 0
fi

hosts=$(<var/hosts)
id_rsa=$(<var/id_rsa)
hostname=$(<var/hostname)

if [[ -z "$id_rsa" ]] ; then
    echo 'You need to put the id_rsa.pub of the ambari-server into /var/id_rsa`'
    exit 0
fi


# starting setup
sudo su
sudo apt update
sudo apt upgrade
sudo apt install python2.7 python python2.7-dev ntp selinux-utils

# ssh password less for ambari server
echo "$id_rsa" >> /root/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# vi /etc/ssh/sshd_config
# AuthorizedKeysFile      /root/.ssh/authorized_keys      .ssh/authorized_keys

hostname $id_rsa
hostnamectl set-hostname $id_rsa

# vi /etc/cloud/cloud.cfg
    # preserve_hostname: true

# config network
echo "$hosts" >> /etc/hosts

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
wget -O /etc/apt/sources.list.d/ambari.list  	http://public-repo-1.hortonworks.com/HDP/ubuntu18/3.x/updates/3.1.0.0/hdp.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
