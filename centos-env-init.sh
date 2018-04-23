#!/bin/bash -l
# centos环境初始化(目录/依赖/时间)
# /app为标准运行目录
# bak为备份目录 data数据存放 www静态页面/项目 server运行工程 down下载 deploy部署/脚本目录

mkdir -p /app/bak
mkdir -p /app/data/
mkdir -p /app/www
mkdir -p /app/server
mkdir -p /app/down
mkdir -p /app/deploy

# 安装基础依赖 此依赖基本满足日常使用 ansible, jumpserver的依赖需求
yum install -y wget sqlite-devel xz gcc automake zlib-devel openssl-devel epel-release git
yum install -y policycoreutils-python openssh-server openssh-clients cronie postfix patch
yum install -y zip unzip lrzsz
yum install -y gcc-c++
yum -y install tcl
yum -y install ntpdate
yum -y install pcre*

# 更换中国时间
\cp -f /usr/share/zoneinfo/Asia/Chongqing /etc/localtime
ntpdate cn.pool.ntp.org

yum update