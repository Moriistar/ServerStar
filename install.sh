#!/bin/bash

# Colors
red="\e[31m"; green="\e[32m"; yellow="\e[33m"; blue="\e[34m"; reset="\e[0m"

# Banner
clear
echo -e "\e[36m"
cat << "EOF"


██████╗░░█████╗░███╗░░██╗███████╗██╗░░░░░
██╔══██╗██╔══██╗████╗░██║██╔════╝██║░░░░░
██████╔╝███████║██╔██╗██║█████╗░░██║░░░░░
██╔═══╝░██╔══██║██║╚████║██╔══╝░░██║░░░░░
██║░░░░░██║░░██║██║░╚███║███████╗███████╗
╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝╚══════╝

░██████╗████████╗░█████╗░██████╗░
██╔════╝╚══██╔══╝██╔══██╗██╔══██╗
╚█████╗░░░░██║░░░███████║██████╔╝
░╚═══██╗░░░██║░░░██╔══██║██╔══██╗
██████╔╝░░░██║░░░██║░░██║██║░░██║
╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝

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
  echo -e "8. Install Haproxy Tunnel"
  echo -e "9. Install Nebula Tunnel"
  echo -e "10. Optimize Xray with WARP"
  echo -e "11. Telegram Monitor"
  echo -e "12. Detect Server Location"
  echo -e "13. Generate Random Local IPv6"
  echo -e "14. Manual Tunnel Setup (Input IP)"
  echo -e "15. Fix WARP (fscarmen + Memory Monitor)"
  echo -e "${green}16. Install RPTraefik Tunnel ${yellow}[NEW]${reset}"
  echo -e "${green}17. Install WARP Socks5 Proxy ${yellow}[NEW]${reset}"
  echo -e "${green}18. Get Local IPv6 from Website ${yellow}[NEW]${reset}"
  echo -e "19. Exit"
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

# New function: Install RPTraefik Tunnel
install_rptraefik() {
    echo -e "${yellow}Installing RPTraefik Tunnel...${reset}"
    echo -e "This will install RPTraefik Tunnel from dev-ir repository."
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        echo -e "${yellow}Git is not installed. Installing git...${reset}"
        sudo apt-get update
        sudo apt-get install -y git
    fi
    
    echo -e "${yellow}Cloning RPTraefik repository and starting installation...${reset}"
    sudo git clone https://github.com/dev-ir/RPTraefik.git /opt/RPTraefik && cd /opt/RPTraefik && bash main.sh
    
    echo -e "${green}RPTraefik Tunnel installation completed.${reset}"
    read -n1 -rp $'Press any key to return to menu...'
}

# New function: Install WARP Socks5 Proxy
install_warp_socks5() {
    echo -e "${yellow}Installing WARP Socks5 Proxy...${reset}"
    echo -e "This will install WARP Socks5 Proxy on port 40000."
    
    # Install WARP Socks5 Proxy
    bash <(curl -sSL https://raw.githubusercontent.com/hamid-gh98/x-ui-scripts/main/install_warp_proxy.sh)
    
    echo -e "\n${green}WARP Socks5 Proxy has been installed.${reset}"
    echo -e "\n${yellow}Configuration Instructions for X-UI:${reset}"
    echo -e "1. Add the following at the end of your outbounds section:"
    echo -e "${blue}"
    echo '"tag": "WARP",'
    echo '"protocol": "socks",'
    echo '"settings": {'
    echo '  "servers": ['
    echo '    {'
    echo '      "address": "127.0.0.1",'
    echo '      "port": 40000'
    echo '    }'
    echo '  ]'
    echo '}'
    echo '}'
    echo -e "${reset}"
    
    echo -e "2. Add the following at the end of your routing rules:"
    echo -e "${blue}"
    echo '"type": "field",'
    echo '"outboundTag": "WARP",'
    echo '"domain": ['
    echo '  "cloudflare.com",'
    echo '  "iran.ir"'
    echo ']'
    echo '}'
    echo -e "${reset}"
    
    echo -e "${yellow}NOTE: To use WARP+, run 'warp a' and select option 2.${reset}"
    
    read -n1 -rp $'Press any key to return to menu...'
}

# New function: Get Local IPv6 from Website
get_online_ipv6() {
    echo -e "${yellow}Fetching Local IPv6 from unique-local-ipv6.com...${reset}"
    
    # Check if curl is installed
    if ! command -v curl &> /dev/null; then
        echo -e "${yellow}Curl is not installed. Installing curl...${reset}"
        sudo apt-get update
        sudo apt-get install -y curl
    fi
    
    # Get the IPv6 address from the website
    echo -e "${yellow}Retrieving Local IPv6 addresses...${reset}"
    
    # Use curl to get the page content and extract the IPv6 addresses
    local webpage=$(curl -s https://unique-local-ipv6.com/)
    
    # Extract the IPv6 addresses using grep
    if [[ -n "$webpage" ]]; then
        echo -e "${green}Retrieved Local IPv6 addresses:${reset}"
        echo -e "${blue}---------------------------------------${reset}"
        echo "$webpage" | grep -o "fd[0-9a-f]\{2\}:[0-9a-f]\{4\}:[0-9a-f]\{4\}:[0-9a-f]\{4\}::/64" | head -5
        echo -e "${blue}---------------------------------------${reset}"
    else
        echo -e "${red}Failed to retrieve IPv6 addresses from the website.${reset}"
        echo -e "${yellow}Generating backup random local IPv6 addresses:${reset}"
        for i in {1..3}; do
            printf "fd%02x:%04x:%04x:%04x::/64\n" $((RANDOM%256)) $((RANDOM%65536)) $((RANDOM%65536)) $((RANDOM%65536))
        done
    fi
    
    read -n1 -rp $'Press any key to return to menu...'
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
    16) install_rptraefik ;;        # New option
    17) install_warp_socks5 ;;      # New option
    18) get_online_ipv6 ;;          # New option
    19) break ;;
    *) echo -e "${red}Invalid option!${reset}"; sleep 1 ;;
  esac
done

clear && echo -e "${green}Exited ServerStar Menu.${reset}" 
