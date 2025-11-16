#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

[[ $EUID -ne 0 ]] && echo -e "${red}错误:${plain} 必须使用 root 用户运行！" && exit 1

echo -e "${green}=== AWS Root 登录管理脚本 ===${plain}"

# -----------------------
# 开启 root 登录
# -----------------------
enable_root_login() {
    echo -e "${yellow}→ 修改 sshd_config ...${plain}"

    sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

    # 修改 cloudimg 配置（Ubuntu/Lightsail）
    if [[ -f /etc/ssh/sshd_config.d/60-cloudimg-settings.conf ]]; then
        echo -e "${yellow}→ 发现 cloudimg 配置，正在修复...${plain}"
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
        sed -i '$a PermitRootLogin yes' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
    fi

    echo -e "${green}✔ 已启用 root 登录${plain}"
}

# -----------------------
# 复制 ubuntu key 到 root
# -----------------------
copy_ssh_key() {
    echo -e "${yellow}→ 复制 SSH 公钥 ...${plain}"

    mkdir -p /root/.ssh
    if [[ -f /home/ubuntu/.ssh/authorized_keys ]]; then
        cp /home/ubuntu/.ssh/authorized_keys /root/.ssh/
        chmod 600 /root/.ssh/authorized_keys
        chmod 700 /root/.ssh
        echo -e "${green}✔ 已复制 ubuntu 公钥到 root${plain}"
    else
        echo -e "${red}× 未找到 /home/ubuntu/.ssh/authorized_keys${plain}"
    fi
}

# -----------------------
# 设置 root 密码
# -----------------------
set_root_pass() {
    echo -e "${yellow}→ 请设置 root 密码：${plain}"
    passwd root
}

# -----------------------
# 重启 SSH 服务
# -----------------------
restart_ssh() {
    echo -e "${yellow}→ 重启 SSH 服务 ...${plain}"
    systemctl daemon-reload 2>/dev/null
    systemctl restart sshd 2>/dev/null
    systemctl restart ssh 2>/dev/null
    systemctl restart ssh.socket 2>/dev/null
    echo -e "${green}✔ SSH 服务已重启${plain}"
}

# -----------------------
# 一键全部执行（推荐）
# -----------------------
run_all() {
    enable_root_login
    copy_ssh_key
    set_root_pass
    restart_ssh
    echo -e "${green}✔ 全部完成！现在可以使用 root 登录了。${plain}"
}

# -----------------------
# 菜单
# -----------------------
show_menu() {
    echo -e "
${green}AWS / Lightsail Root 登录管理${plain}
--------------------------------
${green}1.${plain} 一键全部执行（推荐）
${green}2.${plain} 启用 root 登录
${green}3.${plain} 复制 ubuntu SSH key 到 root
${green}4.${plain} 设置 root 密码
${green}5.${plain} 重启 SSH 服务
${green}6.${plain} 退出脚本
"
    read -rp "请输入选项 [1-6]: " num

    case $num in
        1) run_all ;;
        2) enable_root_login ;;
        3) copy_ssh_key ;;
        4) set_root_pass ;;
        5) restart_ssh ;;
        6) exit 0 ;;
        *) echo -e "${red}请输入正确数字${plain}" ;;
    esac

    echo
    read -rp "按回车返回主菜单..." tmp
}

while true; do
    show_menu
done
