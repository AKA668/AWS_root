# 🛠️ AWS / Lightsail Root 登录管理工具

一个用于 **自动启用 root 登录**、**修复 Lightsail 限制**、**复制 SSH Key**、**设置 root 密码**、**重启 SSH** 的一键管理脚本。

支持以下系统：

- **AWS EC2**
- **AWS Lightsail**
- **Ubuntu / Debian / CentOS**
- 自动检测环境、自动修复 cloudimg、自动安装 awsroot 命令

---

## 🚀 一键安装

只需执行下面这一条命令即可安装，并自动生成 `awsroot` 命令：

```bash
bash <(curl -Ls https://raw.githubusercontent.com/AKA668/AWS_root/main/awsroot.sh)
安装完成后，输入：

bash
复制代码
awsroot
即可打开管理工具。

📌 功能列表
🔥 一键全部执行（推荐）
一键执行以下所有流程：

启用 root 登录

复制 ubuntu 用户 SSH 公钥到 root

设置 root 密码

修复 Lightsail cloudimg 配置

启用 PasswordAuthentication

自动重启 SSH 服务

🧰 主要功能说明
功能编号	功能名称	说明
1	一键全部执行	新手推荐，一次完成所有操作
2	启用 root 登录	自动修改 sshd_config / cloudimg（Lightsail）
3	复制 SSH Key	复制 /home/ubuntu 公钥到 root
4	设置 root 密码	设置 root 用户登录密码
5	禁用 root 登录	恢复默认安全策略
6	查看当前状态	检查 SSH、root、密码登录状态
7	重启 SSH 服务	自动适配 sshd / ssh.socket
8	卸载工具	删除 awsroot 命令并可恢复原配置
9	退出	退出脚本

🖥️ 菜单界面展示
执行 awsroot 后将显示如下界面：

markdown
复制代码
=== AWS Root 登录管理工具 v1.3 ===
系统类型：Ubuntu 22.04
环境：Lightsail
Root 登录：未启用
SSH 密码登录：未启用
SSH 状态：running (ssh.socket)

-----------------------------
 1. 一键全部执行（推荐）
 2. 启用 root 登录
 3. 复制 ubuntu SSH key
 4. 设置 root 密码
 5. 禁用 root 登录
 6. 查看当前状态
 7. 重启 SSH 服务
 8. 卸载工具（恢复默认）
 9. 退出
-----------------------------
⚡ 自动识别功能（无需手动判断）
脚本会自动检测：

是否 AWS Lightsail

是否 AWS EC2

是否已开启 root 登录

PasswordAuthentication 是否开启

SSH 服务运行方式：sshd / ssh / ssh.socket

是否存在 /etc/ssh/sshd_config.d/60-cloudimg-settings.conf

Lightsail 限制是否已修复

自动处理，无需人工介入。

🧹 卸载（恢复默认环境）
执行：

bash
复制代码
awsroot
选择菜单中的：

markdown
复制代码
8. 卸载工具（恢复默认）
或手动删除 awsroot 命令：

bash
复制代码
rm -f /usr/local/bin/awsroot
🛡️ 使用注意事项
开启 root 登录可能降低安全性，请注意配置安全组或防火墙。

Lightsail 默认不允许 root 登录，本工具已自动修复限制。

EC2 某些镜像可能禁用密码登录，请按需开启。

❤️ 贡献与反馈
欢迎提交 PR 或 Issue。

如果对你有帮助，欢迎 Star ⭐ 支持！

GitHub 仓库地址：
https://github.com/AKA668/AWS_root
