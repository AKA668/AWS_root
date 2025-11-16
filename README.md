# 🛠️ AWS / Lightsail Root 登录管理工具

一个用于 **自动启用 root 登录、修复 Lightsail 限制、复制 SSH Key、设置 root 密码、重启 SSH** 的一键管理脚本。

支持系统：

- AWS EC2  
- AWS Lightsail  
- Ubuntu / Debian / CentOS  

脚本具备：

- 自动检测环境（EC2 / Lightsail / 普通 Linux）
- 自动修复 cloudimg
- 自动启用 root
- 自动安装 `awsroot` 命令

---

## ⚡ 一键安装（最推荐方式）

运行下面这一条命令即可安装，并自动生成全局命令 `awsroot`：

```
bash <(curl -Ls https://raw.githubusercontent.com/AKA668/AWS_root/main/awsroot.sh)
```

安装完成后输入：

```
awsroot
```

即可打开管理面板。

---

## 🚀 一键全部执行（推荐，新手必选）

选择菜单中的 **1. 一键全部执行（推荐）** 会自动执行以下全流程：

1. 启用 root 登录  
2. 复制 ubuntu 用户 SSH 公钥到 root（Lightsail 必须）  
3. 设置 root 密码  
4. 启用 PasswordAuthentication  
5. 修复 Lightsail cloudimg（如存在）  
6. 覆盖和修复 sshd_config  
7. 自动重启 SSH 服务  
8. 确认 root 登录可用  

真正做到 **全自动、不需要手动修改任何 SSH 文件**。

---

## 📘 全部功能说明表（完整）

| 功能编号 | 功能名称           | 说明                                                   |
|----------|--------------------|--------------------------------------------------------|
| 1        | 一键全部执行       | 新手推荐，一次完成所有 root 启用任务                  |
| 2        | 启用 root 登录     | 自动修改 sshd_config / cloudimg（Lightsail）          |
| 3        | 复制 SSH Key       | 将 ubuntu 公钥复制到 root（Lightsail 必需）           |
| 4        | 设置 root 密码     | 手动设置 root 密码                                    |
| 5        | 禁用 root 登录     | 恢复 SSH 默认安全配置                                  |
| 6        | 查看当前状态       | 显示系统检测、SSH 状态、cloudimg 等详细信息           |
| 7        | 重启 SSH 服务      | 自动适配 sshd / ssh / ssh.socket                      |
| 8        | 卸载工具           | 删除 awsroot 命令并恢复默认 SSH 配置                  |
| 9        | 退出               | 退出脚本                                              |

---

## 🌍 Lightsail 自动修复能力

如果脚本检测到你使用的是 Lightsail，会自动执行：

- 修复 `/etc/ssh/sshd_config.d/60-cloudimg-settings.conf`
- 解除 PasswordAuthentication 限制
- 自动追加 `PermitRootLogin yes`
- 解决 Lightsail 阻止 root 登录的问题

---

## 🔍 自动检测信息（运行脚本时显示）

示例：

```
=== AWS Root 登录管理工具 v1.3 ===
系统类型：Ubuntu 22.04（Lightsail）
环境：Lightsail
Root 登录：未启用
SSH 密码登录：已启用
Cloudimg 修复：未修复
SSH 状态：running
```

---

## 📦 卸载工具（恢复默认）

选择菜单中的 **8. 卸载工具** 会：

- 删除 `/usr/bin/awsroot`
- 恢复 SSH 默认配置
- 删除 cloudimg 追加配置
- 不破坏你的原有 key

---

## ⭐ 项目地址  
https://github.com/AKA668/AWS_root

欢迎 Star ⭐ 支持！

