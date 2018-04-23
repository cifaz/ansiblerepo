#!/bin/bash -l
# 安装galaxy依赖

ansible-galaxy install andrewrothstein.java-oracle
ansible-galaxy install andrewrothstein.kafka
ansible-galaxy install wtanaka.apache-kafka
ansible-galaxy install ChristopherDavenport.universal-java
ansible-galaxy install zaxos.tomcat-ansible-role
ansible-galaxy install cifaz.generate-ssh-key
ansible-galaxy install cifaz.gitlab-zh
ansible-galaxy install cifaz.ops-env
ansible-galaxy install cifaz.zentao
ansible-galaxy install cifaz.jumpserver
ansible-galaxy install DavidWittman.redis
ansible-galaxy install debops.dnsmasq

ansible-galaxy install geerlingguy.java
ansible-galaxy install geerlingguy.mysql
ansible-galaxy install geerlingguy.nginx
ansible-galaxy install geerlingguy.nodejs
ansible-galaxy install geerlingguy.gitlab
ansible-galaxy install geerlingguy.jenkins
ansible-galaxy install jasonroyle.rabbitmq
ansible-galaxy install kanedafromparis.xwiki-tomcat
ansible-galaxy install kyl191.openvpn
ansible-galaxy install savoirfairelinux.nexus3-oss
ansible-galaxy install greendayonfire.mongodb
ansible-galaxy install tersmitten.ssh-keys
ansible-galaxy install williamyeh.oracle-java