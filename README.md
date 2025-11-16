# 🚀 AWS / Lightsail Root 登录管理工具

一个用于 **自动启用 root 登录、修复 Lightsail 限制、复制 SSH Key、设置 root 密码、重启 SSH 服务** 的一键管理脚本。  
同时支持 **EC2、Lightsail、Ubuntu、Debian、CentOS**，并具备自动检测环境、自动修复 cloudimg、自动安装全局命令等功能。

---

## 🔍 自动检测能力（脚本执行时自动显示）

脚本运行后会自动检测：

- 系统类型（Ubuntu / Debian / CentOS）
- 是否为 AWS Lightsail
- 是否运行在 EC2 还是标准 Linux
- root 登录是否启用
- SSH 密码登录是否启用
- cloudimg 是否存在（Lightsail 特有）
- cloudimg 是否已修复
- SSH 服务状态（running / inactive / failed）
- SSH 配置文件是否被覆盖
- 是否有 `/etc/ssh/sshd_config.d` 目录
- 是否存在 `60-cloudimg-settings.conf`

示例自动检测输出：

=== AWS Root 登录管理工具 v1.3 ===
系统类型：Ubuntu 22.04（Lightsail）
环境：Lightsail
Root 登录：未启用
SSH 密码登录：已启用
Cloudimg 修复：未修复
SSH 状态：running

yaml
复制代码

---

## ⚡ 一键安装（最推荐方式）

只需执行一条命令即可安装，并自动生成全局命令 **awsroot**：

```bash
bash <(curl -Ls https://raw.githubusercontent.com/AKA668/AWS_root/main/awsroot.sh)
安装完成后即可输入：

bash
复制代码
awsroot
打开管理面板。

🎯 一键全部执行（推荐，新手必选）
选项 1. 一键全部执行（推荐） 会自动执行以下全流程：

启用 root 登录

复制 ubuntu 用户 SSH 公钥到 root（Lightsail 必须）

设置 root 密码

启用 PasswordAuthentication

修复 Lightsail cloudimg （如存在）

覆盖和修复 sshd_config

自动重启 SSH 服务

确认 root 登录可用

真正做到一条龙自动化，不需要任何手动修改 SSH 文件。

🧩 全部功能说明表（完整）
以下是脚本所有功能的详细说明（按菜单顺序）：

功能编号	功能名称	说明
1	一键全部执行	新手推荐，一次完成所有 root 启用任务
2	启用 root 登录	自动修改 sshd_config / cloudimg（Lightsail）
3	复制 SSH Key	将 ubuntu 公钥复制到 root（Lightsail 必需）
4	设置 root 密码	手动设置 root 密码
5	禁用 root 登录	恢复 SSH 默认安全配置
6	查看当前状态	显示系统检测、SSH 状态、cloudimg 配置等详细信息
7	重启 SSH 服务	自动兼容 sshd / ssh / ssh.socket
8	卸载工具	删除 awsroot 命令并恢复默认 SSH 配置
9	退出	退出脚本

💡 Lightsail 自动修复能力
当检测到你使用的是 Lightsail 时，脚本会自动执行：

✔ 修复 /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
✔ 解除 PasswordAuthentication 限制
✔ 自动追加 PermitRootLogin yes
✔ 解决 Lightsail 阻止 root 登录的问题

🌍 支持系统
Ubuntu 18.04 / 20.04 / 22.04 / 24.04

Debian 9 / 10 / 11 / 12

CentOS 7 / 8

AWS EC2

AWS Lightsail

📁 卸载工具（恢复系统默认）
选择菜单 8. 卸载工具 会：

删除 /usr/bin/awsroot

恢复系统默认 SSH 配置（备份恢复）

清理 cloudimg 追加项

不破坏你的原有配置

卸载后 SSH 设置恢复回出厂状态。

📌 使用示例截图（文本版）
markdown
复制代码
=== AWS Root 登录管理工具 v1.3 ===
系统类型：Ubuntu 22.04（Lightsail）
Root 登录：已启用
SSH 密码登录：已启用
Cloudimg 修复：已修复
SSH 服务状态：运行中

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
请输入选项 [1-9]:
📦 项目地址
GitHub 仓库：

👉 https://github.com/AKA668/AWS_root

欢迎 Star ⭐，也欢迎 Issue 与 PR！
