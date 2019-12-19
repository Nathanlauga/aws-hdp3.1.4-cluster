# Hortonworks cluster with AWS (HDP 3.1.4.0, Ambari 2.7.4.0 & Ubuntu18)

Hello everyone, this is a repository to find all procedure to easily create a cluster using AWS services and Hortonworks with the latest version of HDP (3.1.4.0).

**IMPORTANT :** this repository is for a school project so, I will not maintain it so I hope it could help you, but it was made by a curious Data Scientist ;) 

## Ressources

* [AWS Console](https://aws.amazon.com/console/)
* [Ambari 2.7.4.0 installation](https://docs.cloudera.com/HDPDocuments/Ambari-2.7.4.0/bk_ambari-installation/content/ch_Getting_Ready.html)

## Procedure detail

This procedure helps you through machine setup for the Ambari server, and ambari agents. So to the first connection with ssh to the host confirmation. **The next steps (like choosing Service, for example Spark & Zeppelin notebook) will not be cover here**.

## My setup

* 4 machines Ubuntu18 :
    * 2 instances `t2.xlarge` 30GB SSD, 16GB RAM : one for ambari server and the other for name node.
    * 2 instances `t2.micro` 30GB SSD, 1GB RAM : both data nodes.

I create a security group is not that secured, but it was not my goal so here is the rules :
* All TCP : 0.0.0.0/0
* All UDP : 0.0.0.0/0

## Setup machines

This section is based on the following documentation : [Apache Ambari Installation
PDF](https://docs.cloudera.com/HDPDocuments/Ambari-2.7.4.0/bk_ambari-installation/content/ch_Getting_Ready.html).

On each server, you need to execute the following commands
```
sudo su
apt-get install git
git clone https://github.com/Nathanlauga/aws-hdp3.1.4-cluster
cd aws-hdp3.1.4-cluster/scripts/
```

After that, find your machine IP and decide which hostname you want to use (you can find this into `EC2 Instance view` on the **Private IPs** attribute).

For the hostname you can use the **Private DNS** set by AWS.

Once you have it, copy it into /scripts/var/hosts
```
vi var/hosts
```

For example I used this configuration :
```
172.31.22.105   ambari-server
172.31.25.222   name-node 
```

Then on the **ambari server** machine you need to setup ssh, so execute `./setup_ssh.sh` script and **copy the output into all machines `var/id_rsa` file**.

```
./setup_ssh.sh
```

Once you have all information set into `var/hosts` and `var/id_rsa` on each machines you can execute the init script with the hostname of the current machine. **It has to be the same that you set into `var/hosts` file!**

Example : 
```
./init.sh ambari-server
```

After init done on each machine, you can install `ambari-server` on your machine that correspond to this role.
```
./setup_ambari_server.sh
```

You can connect to your Ambari server with Public IP of AWS machine at port 8080.
    login : admin
    password : admin

## [Optional] Setup MySQL db for hive and others services

Some HDP services require a database so you can install MySQL by executing the following script on any machine you want (prefer one with storage capacity).

```
./setup_mysql.sh
```

After that if you need to create user for some service, you can use `./generate_user_sql.sh` script with user as argument and copy the code to execute it after `mysql` command.

```
./generate_user_sql.sh hive
```

**OUTPUT** 
```
CREATE USER 'hive'@'localhost' IDENTIFIED BY 'hive';
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'localhost';
CREATE USER 'hive'@'%' IDENTIFIED BY 'hive';
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

## End
Thanks for reading,\
*Nathan*