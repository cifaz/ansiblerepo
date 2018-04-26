cifaz.ansible-ops-env
========================

通用环境建立库
本工具的目的是使用ansible尽可能快的时间建立一套测试/生产环境  
因此本工具是一套集成工具, 可以使用一些约定方法,   
快速建立起自己的一套基本的自动化环境  
21个 playbook 对应19个Role

* 机器初始化成功
* 下载库
````
# 约30-50秒
mkdir -p /app/down/ && \
cd /app/down/ && \
yum install -y git
    
# 约1分钟
git clone https://github.com/cifaz/ansiblerepo.git
  
# 照如下, 初始化yum环境, 约7分钟, 会更新yum包
cd ansiblerepo && \
chmod -R u+x ./*.sh && \
./install-centos-aliyum.sh

# 初始化, 约4分钟
./install-centos-ops-init.sh

````

### 你在使用本工具前可以先使用如下工具初始化你的基本环境
 - [阿里云YUM安装脚本](yumforali.sh) 可以快速将你的服务器切换为阿里云YUM
    ```
       ./install-centos-aliyum.yml.sh
    ```
 - [环境初始化EPEL](bak/centos-env-init.sh)   
    1.可以初始化基本目录,   
    2.初始化常用依赖组件/工具(如ansible/jumpserver的依赖)   
    3.更换时区和设置中国时间, 更新yum缓存  
    4.**其它自己按需设定**
    ```
      # 初始化
      ./install-centos-ops-init.sh
    ```

### 初始化ansible主机 目前仅限于centos7
 - 正常情况为localhost, 本机
 - 切换yum, 阿里云
 - 基本环境初始化
 ````
 以上常用依赖(环境初始化EPEL)已经初始化过EPEL了, 如果没有使用以上脚本请自行初始化环境
 约2分钟
 yum install -y ansible
   
 安装完毕检查
 ansible --version
   
 ansible配置
 mkdir -p /app/data/ansible/{hosts,playbooks}
   
 vi /etc/ansible/ansible.cfg
 加下如下配置 [defaults]节点下
 inventory=/app/data/ansible/hosts/
 roles_path=/app/data/ansible/playbooks/roles:/etc/ansible/roles:/usr/share/ansible/roles
 host_key_checking = False
 callback_whitelist = profile_tasks
 
 初始化完毕, cifaz库, 安装时会把常用库都安装进来
 cd /app/data/ansible/playbooks && \
 git clone https://github.com/cifaz/ansiblerepo.git
   
 开始准备自动部署吧
 ````

### 初始化其它所有机器
 - 如下使用
  
### 测试环境安装部署
```
- 准备playbook
  cp -rf ansiblerepo/*.sh ./ && \
  cp -rf ansiblerepo/conf/ ./ && \
  cp -rf ansiblerepo/*.yml ./ 
  
- 建立机器配置
  建议同类机器建立, 如
  web: web机器
  db: 数据库, 主数据库
  db2: 从数据库, 备份数据
  ops: 运维机器, 一般指本机, 也可以用local
  public: 公共组件机器
  各种机器类型又可以再进行细分
   
  touch /app/data/ansible/hosts/web && \ 
  touch /app/data/ansible/hosts/db && \
  touch /app/data/ansible/hosts/local && \
  touch /app/data/ansible/hosts/public 
  
  例:
  共3台机器
  192.168.19.254 / 253 / 252
  ops机, localhost不分配
  db: 253
  web: 252
  
  // web
  vi /app/data/ansible/hosts/web
  [web]
  192.168.19.252
  
  // db 
  vi /app/data/ansible/hosts/db
  [db]
  192.168.19.253
  
- ops机安装galaxy, 约5分钟, 下载所有依赖项, 有些慢, 主要看网速了
  ansible-playbook install-ansible-galaxy.yml
  
- 初始化分发ssh-key, 不重复发放
  ansible-playbook install-init-generate-ssh-key.yml
  # 约6分钟, 注:此步时, 需要所有机器密码一致 
  ansible-playbook install-init-publish-ssh-key.yml -k
  
- 分环境(请自行划分)
  运维机一台, jdk, jumpserver, dnsmasq, openvpn, jenkins, nginx, zentao, xwiki
  仓库服务, gitlab, nexus
  WEB服务二台, nodejs, jdk, tomcat, zookeeper
  数据库一台, kafka, redis, mysql, mongodb
  基础服务, 业务服务, 暂无, 和WEB服务有点像, 如CAS, dubbo监控, 部署服务等
  
  测试规划hosts
  localhost: ops-server ware-server
  web: web-server web-base-server
  db: db-server
  zookeeper: db-server web-server localhost
  
  这些server预置对应哪些服务
  
- 运维机
  常规安装, 
  如下配置需要自己处理
  nginx, /etc/nginx/nginx.conf 及 /etc/nginx/conf.d/下的文件需要建立, 模板
  dnsmasq, /etc/dnsmasq.d/下建立自己的域名拦截解析, 模板
 
- 配置 var.yml 修改为自己合适的配置, 
  其它配置如路径, 规划为通用路径, 可不修改, 但请修改各应用端口号及IP
 
- 配置安装脚本 前缀为install-zone的为各服务器脚本, 此为示例, 可修改为合适自己的脚本 
  
- 安装
  # 约8分钟
  ansible-playbook install-zone-zookeeper.yml
  # 约55分, kafka依赖zookeeper, 需要安装yum repo (mysql,19 + mongodb,31 + redis/kafka,5)
  ansible-playbook install-zone-db.yml
  # 约40分钟, jumpserver依赖redis, mysql
  ansible-playbook install-zone-ops.yml
  # 约4分钟， 不含JDK安装时间
  ansible-playbook install-zone-web.yml
  
```


### 注意
- 遇到[ERROR]: failed to download the file时, 请重新下载
- 下载时提示已下载
```
[WARNING]: - cifaz.ops-env (master) is already installed - use --force to change version to unspecified
加 -f 参数重新强制下载
ansible-galaxy install cifaz.ops-env -f
```
- zookeeper启动报错, Error: Could not find or load main class org.apache.zookeeper.server.quorum.QuorumPeerMain
  是安装包下载不完整


License
-------

MIT

Author Information
------------------

ccz <hanlin2531@163.com>

