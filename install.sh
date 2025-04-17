#!/bin/bash

# Colors
red="\e[31m"; green="\e[32m"; yellow="\e[33m"; blue="\e[34m"; reset="\e[0m"

# Banner
clear
echo -e "\e[36m"
cat << "EOF"
  ____   ___   _   _ _____ _      _____  ____  _    ____  _   _ 
 |  _ \ / _ \ | \ | | ____| |    | ____|/ ___|| |  |  _ \| \ | |
 | |_) | | | ||  \| |  _| | |    |  _|  \___ \| |  | |_) |  \| |
 |  __/| |_| || |\  | |___| |___ | |___  ___) | |__|  __/| |\  |
 |_|    \___/ |_| \_|_____|_____|_____| |____/|____|_|   |_| \_|

             Telegram Channel: @ServerStar_ir
                     Project: PANEL STAR
EOF
echo -e "\e[0m"
sleep 2

print_menu() {
  clear
  echo -e "${blue}==================== ServerStar Menu ====================${reset}"
  echo -e "1. Update & Install X-UI Prerequisites"
  echo -e "2. Obtain SSL Certificate (Let's Encrypt)"
  echo -e "3. Install X-UI Panel (MHSanaei)"
  echo -e "4. Install TX-UI Panel (AghayeCoder)"
  echo -e "5. Install Alireza X-UI Panel (v1.8.9)"
  echo -e "6. Install TX-UI Theme"
  echo -e "7. Install Automatic Backup (AC_Lover)"
  echo -e "8. Install Haproxy Tunnel (IPv4/IPv6)"
  echo -e "9. Install Nebula Tunnel"
  echo -e "10. Optimize Xray with WARP"
  echo -e "11. Telegram Monitor"
  echo -e "12. Detect Server Location"
  echo -e "13. Generate Random Local IPv6"
  echo -e "14. Manual Tunnel Setup (Input IP)"
  echo -e "15. Fix WARP (fscarmen + Memory Monitor)"
  echo -e "16. Exit"
  echo -ne "\nSelect an option: "
}

update_server_and_prereqs() {
  echo -e "${yellow}Updating system and installing prerequisites...${reset}"
  sudo apt-get update && sudo apt-get upgrade -y
  sudo apt-get dist-upgrade -y
  echo -e "${green}System updated successfully.${reset}"
  read -n1 -rp $'Press any key to return to menu...'
}

obtain_ssl_certificate() {
  read -p "Enter your domain (e.g. host.example.com): " domain
  read -p "Enter your email address: " email
  echo -e "${yellow}Installing acme.sh and requesting certificate...${reset}"
  apt install curl socat -y
  curl https://get.acme.sh | sh
  ~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
  ~/.acme.sh/acme.sh --register-account -m "$email"
  ~/.acme.sh/acme.sh --issue -d "$domain" --standalone
  ~/.acme.sh/acme.sh --installcert -d "$domain" \
    --key-file /root/private.key \
    --fullchain-file /root/cert.crt
  echo -e "${green}SSL Certificate installed for $domain.${reset}"
  read -n1 -rp $'Press any key to return to menu...'
}

install_mhsanaei_xui() {
  echo -e "${green}Installing MHSanaei X-UI...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
}

install_txui() {
  echo -e "${green}Installing TX-UI Panel...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/AghayeCoder/tx-ui/master/install.sh)
}

install_alireza_xui() {
  echo -e "${green}Installing Alireza X-UI v1.8.9...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/alireza0/x-ui/master/install.sh)
}

install_txui_theme() {
  echo -e "${green}Installing TX-UI Theme...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/AghayeCoder/tx-themehub/master/install.sh)
}

install_backup_script() {
  echo -e "${green}Installing Auto Backup Script...${reset}"
  bash <(curl -Ls https://github.com/AC-Lover/backup/raw/main/backup.sh)
}

install_haproxy_tunnel() {
  echo -e "${green}Installing Haproxy Tunnel...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/dev-ir/HAProxy/master/main.sh)
}

install_nebula() {
  echo -e "${green}Installing Nebula Tunnel...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/MrAminiDev/NebulaTunnel/main/install.sh)
}

optimize_xray_warp() {
  echo -e "${green}Installing Xray Optimizer with WARP...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/dev-ir/Xray-WARP-Optimizer/main/install.sh)
}

setup_telegram_monitor() {
  echo -e "${yellow}Installing Telegram Monitor...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/dev-ir/Telegram-Monitor/main/install.sh)
}

check_location() {
  echo -e "${yellow}Detecting server location...${reset}"
  country=$(curl -s https://ipinfo.io/country)
  echo -e "\nServer Location: ${green}$country${reset}"
  read -n1 -rp $'Press any key to return to menu...'
}

generate_ipv6() {
  echo -e "${yellow}Generating random local IPv6 (fd00::/8)...${reset}"
  for i in {1..3}; do
    printf "fd%02x:%02x%02x:%02x%02x::/64\n" $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256))
  done
  read -n1 -rp $'Press any key to return to menu...'
}

manual_tunnel_setup() {
  read -p $'Enter Server IPv4: ' ipv4
  read -p $'Enter Server IPv6 (without ::): ' ipv6
  echo -e "\nManual Tunnel Info:"
  echo -e "IPv4: ${green}$ipv4${reset}"
  echo -e "IPv6: ${green}$ipv6::1${reset}"
  echo -e "(Use with GOST or Rathole)"
  read -n1 -rp $'Press any key to return to menu...'
}

fix_warp_fscarmen() {
    echo "Installing WARP (fscarmen)..."
    wget -N https://gitlab.com/fscarmen/warp/-/raw/main/menu.sh && bash menu.sh

    CONFIG_FILE="/etc/wireguard/proxy.conf"
    NEW_ENDPOINT="engage.cloudflareclient.com:2408"

    if [ -f "$CONFIG_FILE" ]; then
        echo "Editing $CONFIG_FILE and replacing Endpoint..."
        sed -i '/^Endpoint = /c\Endpoint = '"$NEW_ENDPOINT" "$CONFIG_FILE"
        sed -i '/^$/d' "$CONFIG_FILE"  # Remove empty lines
    else
        echo "File proxy.conf not found. Operation canceled."
        return
    fi

    echo "Running warp y to reconnect..."
    warp y

    echo "Creating wireproxy RAM usage monitor script..."
    LOG_FILE="/var/log/wireproxy_monitor.log"
    MONITOR_SCRIPT="/root/monitor_wireproxy.sh"

    sudo touch "$LOG_FILE"
    sudo chmod 644 "$LOG_FILE"

    cat > "$MONITOR_SCRIPT" << EOF
#!/bin/bash

PROCESS_NAME="wireproxy"
MEMORY_LIMIT=2000
CHECK_INTERVAL=600
LOG_FILE="$LOG_FILE"

is_process_running() {
    pgrep -x "\$PROCESS_NAME" > /dev/null
    return \$?
}

check_memory_usage() {
    MEMORY_USAGE=\$(ps -C "\$PROCESS_NAME" -o rss= | awk '{sum+=\$1} END {print sum/1024}')

    if [ -z "\$MEMORY_USAGE" ]; then
        echo "[\$(date)] No RAM usage found for \$PROCESS_NAME." | tee -a "\$LOG_FILE"
        return
    fi

    if (( \$(echo "\$MEMORY_USAGE > \$MEMORY_LIMIT" | bc -l) )); then
        echo "[\$(date)] RAM usage for \$PROCESS_NAME exceeded the limit: \$MEMORY_USAGE MB" | tee -a "\$LOG_FILE"
        echo "[\$(date)] Restarting \$PROCESS_NAME..." | tee -a "\$LOG_FILE"
        sudo systemctl restart wireproxy
        if [ \$? -ne 0 ]; then
            echo "[\$(date)] Error restarting \$PROCESS_NAME." | tee -a "\$LOG_FILE"
        else
            echo "[\$(date)] \$PROCESS_NAME was successfully restarted." | tee -a "\$LOG_FILE"
        fi
    else
        echo "[\$(date)] RAM usage for \$PROCESS_NAME is within the allowed range: \$MEMORY_USAGE MB" | tee -a "\$LOG_FILE"
    fi
}

while true; do
    if is_process_running; then
        check_memory_usage
    else
        echo "[\$(date)] Process \$PROCESS_NAME is not running." | tee -a "\$LOG_FILE"
    fi
    sleep "\$CHECK_INTERVAL"
done
EOF

    chmod +x "$MONITOR_SCRIPT"

    echo "Creating wireproxy RAM monitor service..."
    cat > /etc/systemd/system/monitor-wireproxy.service << EOF
[Unit]
Description=Monitor and Restart WireProxy Service
After=network.target

[Service]
ExecStart=$MONITOR_SCRIPT
Restart=always
User=root
StandardOutput=append:$LOG_FILE
StandardError=append:$LOG_FILE

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable monitor-wireproxy
    systemctl start monitor-wireproxy

    echo -e "\n✅ Operation completed successfully. wireproxy RAM monitor service is active."
} 

# Menu loop
while true; do
  print_menu
  read -r option
  case $option in
    1) update_server_and_prereqs ;;
    2) obtain_ssl_certificate ;;
    3) install_mhsanaei_xui ;;
    4) install_txui ;;
    5) install_alireza_xui ;;
    6) install_txui_theme ;;
    7) install_backup_script ;;
    8) install_haproxy_tunnel ;;
    9) install_nebula ;;
    10) optimize_xray_warp ;;
    11) setup_telegram_monitor ;;
    12) check_location ;;
    13) generate_ipv6 ;;
    14) manual_tunnel_setup ;;
    15) fix_warp_fscarmen ;;
    16) break ;;
    *) echo -e "${red}Invalid option!${reset}"; sleep 1 ;;
  esac
done

clear && echo -e "${green}Exited ServerStar Menu.${reset}"
