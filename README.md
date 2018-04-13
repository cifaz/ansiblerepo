### ansible工作常用库
- - -

#### ansible安装
##### centos7

[更换阿里云](https://www.5yun.org/13450.html)

目标: 最少的步骤搭建一个自动化的内部测试环境

```

======================================
**准备工作 

准备yum环境 [更换阿里云脚本](yumforali.sh)
yum install -y wget
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo 
wget -P /etc/yum.repos.d/ http://mirrors.aliyun.com/repo/epel-7.repo 
yum clean all && yum makecache
yum update
  
======================================
**准备ansible环境
下载并建立目录
mkdir -p /app/data/ansible/{hosts, playbook}/
   
git clone https://github.com/cifaz/ansiblerepo.git
复制文件到books中, 准备执行
\cp -rf ./ansiblerepo/* ./
  
安装ansible
yum install -y ansible
  
测试过程中, git更新并执行
cd ansiblerepo && git pull && \cp -rf ./* ../ && cd ../
  
======================================
**分发密钥 - 详见publish-ssh-key.yml
  
======================================
**目录规划及安装基本依赖
ansible-playbook all init-centos.yml
  
======================================
**安装所有常用ansible组件
Oefenweb/ansible-ssh-keys 替代自己写的ssh-key
ansible-galaxy install williamyeh.oracle-java
ansible-galaxy install geerlingguy.gitlab gitlab-zh自己编写插件
ansible-galaxy install geerlingguy.jenkins 

ansible-galaxy install kanedafromparis.xwiki-tomcat 需要严重验证, 3年前的
  
geerlingguy.mysql 默认没有安装最新版本, 不是最新, 安装repo
ansible-galaxy install DavidWittman.redis epel中已经有3.2.10
ansible-galaxy install Stouts.mongodb 不是最新, 安装repo
ansible-galaxy install jasonroyle.rabbitmq 暂未测
ansible-galaxy install andrewrothstein.kafka 已成功安装, 未测试
ansible-galaxy install debops.dnsmasq 
  
ansible-galaxy install AnsibleShipyard.ansible-zookeeper 有些国外地址需要修改
ansible-galaxy install ChristopherDavenport.universal-tomcat 可选指定版本tomcat6-9
ansible-galaxy install geerlingguy.nodejs
ansible-galaxy install savoirfairelinux.nexus3-oss 可指定详细版本
  
ansible-galaxy install geerlingguy.gitlab 使用他们的, 但需要做一个中文插件, 并链接到他的插件中, 联系他
    
ansible-galaxy install geerlingguy.nginx
ansible-galaxy install sansible.openvpn
   
未做清单
gitlab等安装后不需要更新的 加入到yum.conf中
   
以上所有第三方一次性安装, 并进行设置/配置文件替换等, 
以符合安装需求, 并把所有常用配置及配置文件集中进行管理, 方便快速搭建
   
以上所有应用安装后未进行正常的使用, 需要观察, 有问题修正push
  
  
```
#### 组件 - 开发清单
##### 基础组件
  * publish-ssh-key.yml 不能单独运行 自己生成key然后执行, 具体参见内容

##### 数据库

##### 队列

##### 应用


##### 待整理
```
  其它运维工具
  以应用为中心的全生命周期管理平台——Portal
  从需求--开发--测试--交付—运维的一个闭环
  zabbix 监控 
  ansible-galaxy install dj-wasabi.zabbix-agent 
  ansible-galaxy install dj-wasabi.zabbix-server
  ansible-galaxy install dj-wasabi.zabbix-proxy
  
  rabbit
  elasticsearch
  Gerrit
  Docker
  Chef
  codis
  Kubernetes
  Vagrant
  Logstash
```

ansible可以便捷安装jumpserver啦, 后续持续更新, 支持更多系统, 目前支持centos
playbook: ansible-galaxy install cifaz.jumpserver
git地址: https://github.com/cifaz/ansible-jumpserver
一键安装更轻松, 其它ansible集合库, https://github.com/cifaz
