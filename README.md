# Hortonworks cluster with AWS (HDP 3.1.4.0, Ambari 2.7.4.0 & Ubuntu18)

Hello everyone, this is a repository to find all procedure to easily create a cluster using AWS services and Hortonworks with the latest version of HDP (3.1.4.0).

**IMPORTANT :** this repository is for a school project so, I will not maintain it so I hope it could help you, but it was made by a curious Data Scientist ;) 

## Ressources

* [AWS Console](https://aws.amazon.com/console/)
* [Ambari 2.7.4.0 installation](https://docs.cloudera.com/HDPDocuments/Ambari-2.7.4.0/bk_ambari-installation/content/ch_Getting_Ready.html)

## Procedure detail

This procedure helps you through machine setup for the Ambari server, and ambari agents. So to the first connection with ssh to the host confirmation. **The next steps (like choosing Service, for example Spark & Zeppelin notebook) will not be cover here but you will find some bugs that I had in the `bugs/` directory**.

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

    git clone https://github.com/Nathanlauga/aws-hdp3.1.4-cluster

