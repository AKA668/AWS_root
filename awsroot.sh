#!/bin/bash
# ==========================================================
#  AWS / Lightsail Root 登录管理工具（单文件版）
#  安装命令：
#  bash <(curl -Ls https://raw.githubusercontent.com/AKA668/AWS_root/main/awsroot.sh)
# ==========================================================

APP_NAME="awsroot"
INSTALL_PATH="/usr/local/bin/$APP_NAME"

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

# -----------------------
# 自动安装（复制本脚本为 /usr/local/bin/awsroot）
# -----------------------
if [[ "$0" != "$INSTALL_PATH" ]]; then
    echo -e "${green}► 正在自动安装 $APP_NAME ...${plain}"
    curl -fsSL "https://raw.githubusercontent.com/AKA668/AWS_root/main/awsroot.sh" -o "$INSTALL_PATH"
    chmod +x "$INSTALL_PATH"
    echo -e "${green}✔ 安装完成！现在可直接输入：  $APP_NAME${plain}"
    echo
    exec $APP_NAME
    exit
fi

# -----------------------
# 检查是否为 root
# -----------------------
[[ $EUID -ne 0 ]] && echo -e "${red}错误:${plain} 必须使用 root 用户运行！" && exit 1

# -----------------------
# 检测系统
# -----------------------
check_system() {
    if [[ -f /etc/redhat-release ]]; then
        os="centos"
    elif grep -qi "ubuntu" /etc/issue; then
        os="ubuntu"
    elif grep -qi "debian" /etc/issue; then
        os="debian"
    else
        os="unknown"
    fi
}

# -----------------------
# 判断是否 Lightsail
# -----------------------
is_lightsail() {
    curl -s http://169.254.169.254/latest/meta-data/product-codes | grep -qi 'AmazonLightsail'
}

# -----------------------
# 判断 Root 登录状态
# -----------------------
check_root_enabled() {
    grep -q "^PermitRootLogin yes" /etc/ssh/sshd_config && return 0 || return 1
}

# -----------------------
# 开启 root 登录
# -----------------------
enable_root_login() {
    echo -e "${yellow}→ 启用 root 登录...${plain}"
    sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

    if [[ -f /etc/ssh/sshd_config.d/60-cloudimg-settings.conf ]]; then
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
        sed -i '$a PermitRootLogin yes' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
    fi

    echo -e "${green}✔ root 登录已启用${plain}"
}

# -----------------------
# 复制公钥（Lightsail 必做）
# -----------------------
copy_ssh_key() {
    echo -e "${yellow}→ 正在复制 ubuntu 公钥 ...${plain}"

    mkdir -p /root/.ssh
    if [[ -f /home/ubuntu/.ssh/authorized_keys ]]; then
        cp /home/ubuntu/.ssh/authorized_keys /root/.ssh/
        chmod 600 /root/.ssh/authorized_keys
        chmod 700 /root/.ssh
        echo -e "${green}✔ 已复制 ssh 公钥${plain}"
    else
        echo -e "${red}× 未找到 /home/ubuntu/.ssh/authorized_keys${plain}"
    fi
}

# -----------------------
# 设置 root 密码
# -----------------------
set_root_pass() {
    echo -e "${yellow}→ 设置 root 密码：${plain}"
    passwd root
}

# -----------------------
# 重启 SSH
# -----------------------
restart_ssh() {
    echo -e "${yellow}→ 重启 SSH 服务...${plain}"
    systemctl daemon-reload 2>/dev/null
    systemctl restart sshd 2>/dev/null
    systemctl restart ssh 2>/dev/null
    systemctl restart ssh.socket 2>/dev/null
    echo -e "${green}✔ SSH 已重启${plain}"
}

# -----------------------
# 恢复默认（卸载）
# -----------------------
uninstall_tool() {
    echo -e "${yellow}→ 正在卸载 awsroot ...${plain}"
    rm -f "$INSTALL_PATH"
    echo -e "${green}✔ 已卸载，工具已恢复默认${plain}"
    exit 0
}

# -----------------------
# 显示状态
# -----------------------
show_status() {
    echo -e "${green}=== AWS Root 登录管理工具 v1.3 ===${plain}"

    check_system
    echo -e "系统类型：$os"

    if is_lightsail; then
        echo -e "环境：Lightsail"
    else
        echo -e "环境：EC2 / 标准 Linux"
    fi

    if check_root_enabled; then
        echo -e "Root 登录：${green}已启用${plain}"
    else
        echo -e "Root 登录：${red}未启用${plain}"
    fi

    echo -e "SSH 密码登录：$(grep -q 'PasswordAuthentication yes' /etc/ssh/sshd_config && echo -e "${green}已启用${plain}" || echo -e "${red}未启用${plain}")"

    echo -e "SSH 状态：$(systemctl is-active sshd 2>/dev/null)"
    echo
}

# -----------------------
# 主菜单
# -----------------------
menu() {
    show_status
    echo -e "
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
-----------------------------"

    read -rp "请输入选项 [1-9]: " num

    case $num in
        1) enable_root_login; copy_ssh_key; set_root_pass; restart_ssh ;;
        2) enable_root_login ;;
        3) copy_ssh_key ;;
        4) set_root_pass ;;
        5) sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config; restart_ssh ;;
        6) show_status ;;
        7) restart_ssh ;;
        8) uninstall_tool ;;
        9) exit ;;
        *) echo -e "${red}请输入正确数字${plain}" ;;
    esac
}

# -----------------------
# 循环菜单
# -----------------------
while true; do
    menu
done
