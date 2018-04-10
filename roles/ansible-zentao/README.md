cifaz.ansible-zentao
========================

本实例使用的tar解压安装
```
ansible-galaxy install cifaz.ansible-zentao
```

### 运行
```
- hosts: local
  remote_user: root
  roles:
    - {role: "ansible-zentao", tag: "zentao"}

```

