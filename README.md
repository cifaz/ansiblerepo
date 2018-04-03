### ansible工作常用库
- - -

#### ansible安装
##### centos7

[更换阿里云](https://www.5yun.org/13450.html)

```
目录规划
mkdir -p /app/bak
mkdir -p /app/data/
mkdir -p /app/www
mkdir -p /app/server
mkdir -p /app/down
mkdir -p /app/deploy

安装基础依赖
yum install -y wget sqlite-devel xz gcc automake zlib-devel openssl-devel epel-release lrzsz git
yum install -y policycoreutils-python openssh-server openssh-clients cronie postfix patch
yum install -y zip unzip
yum install -y gcc-c++
yum -y install tcl
yum -y install ntpdate
yum -y install pcre*

更换中国时间
\cp -f /usr/share/zoneinfo/Asia/Chongqing /etc/localtime
ntpdate cn.pool.ntp.org

安装ansible
yum install -y ansible

```
#### 组件 - 开发清单
##### 基础组件
  * publish-ssh-key.yml 不能单独运行 自己生成key然后执行, 具体参见内容

##### 数据库

##### 队列

##### 应用

