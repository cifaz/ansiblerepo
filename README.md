### ansible工作常用库
- - -

#### ansible安装
##### centos7
```
[更换阿里云](https://www.5yun.org/13450.html)

yum install -y wget sqlite-devel xz gcc automake zlib-devel openssl-devel epel-release lrzsz git
yum install -y  policycoreutils-python openssh-server openssh-clients cronie postfix patch

yum install -y ansible

```
##### 组件
1. 基础组件
1.1 publish-ssh-key.yml 不能单独运行 自己生成key然后执行, 具体参见内容

2. 数据库

3. 队列

4. 应用

