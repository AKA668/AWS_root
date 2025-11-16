🚀 AWS / Lightsail Root 登录管理工具

一个用于 自动启用 root 登录、修复 Lightsail 限制、复制 SSH Key、设置 root 密码、重启 SSH 的一键管理脚本。

支持以下环境：

🇺🇸 AWS EC2

☀️ AWS Lightsail

🐧 Ubuntu / Debian / CentOS

🔍 自动检测系统与环境（EC2 / Lightsail）

🔧 自动修复 cloudimg，自动启用 PasswordAuthentication

⚡ 自动安装 awsroot 命令，执行即可打开界面

🛠 一键安装

只需执行下面这一条命令即可安装，并自动生成全局命令 awsroot：

bash <(curl -Ls https://raw.githubusercontent.com/AKA668/AWS_root/main/awsroot.sh)


安装完成后，输入：

awsroot


即可打开管理工具。
⭐ 功能列表
✔ 一键全部执行（推荐）

自动执行以下所有任务：

启用 root 登录

复制 ubuntu 用户 SSH 公钥到 root

设置 root 密码

修复 Lightsail cloudimg 配置

启用 PasswordAuthentication

自动重启 SSH 服务

🧩 主要功能说明
功能编号	功能名称	说明
1	一键全部执行	新手推荐，一次完成所有 root 启用任务
2	启用 root 登录	自动修改 sshd_config / cloudimg
3	复制 SSH Key	将 ubuntu 公钥复制到 root
4	设置 root 密码	手动设置 root 密码
5	禁用 root 登录	恢复安全默认
6	查看当前状态	显示所有登录配置状态
7	重启 SSH 服务	自动适配 systemctl sshd / ssh.socket
8	卸载工具（恢复默认）	删除 awsroot 命令并恢复默认 SSH 配置
9	退出	退出工具
📌 自动检测内容

脚本会自动检测以下系统信息并显示：

系统类型（Ubuntu / Debian / CentOS）

是否为 Lightsail

是否已启用 root 登录

SSH 密码登录状态

cloudimg 是否存在及是否已修复

SSH 服务运行状态

示例：

=== AWS Root 登录管理工具 v1.3 ===
系统类型：Ubuntu 22.04（Lightsail）
Root 登录：已启用
SSH 密码登录：已启用
Cloudimg 修复：已修复
SSH 状态：running

🔧 卸载工具（恢复默认）

支持一键卸载：

删除 awsroot 命令

恢复 SSH 默认配置

删除脚本安装的文件

📄 open-source

GitHub 项目地址：
https://github.com/AKA668/AWS_root

欢迎 Star ⭐、Issues、PR！
