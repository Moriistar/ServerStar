#!/bin/bash

# Script version (for update checks)
SCRIPT_VERSION="1.2.0"

# Colors
red="\e[31m"; green="\e[32m"; yellow="\e[33m"; blue="\e[34m"; magenta="\e[35m"; cyan="\e[36m"; reset="\e[0m"

# Language setup (en for English, fa for Persian/Farsi)
LANGUAGE="fa"

# Translations
declare -A translations
# English translations
translations["en,menu_title"]="ServerStar Menu"
translations["en,exit_message"]="Exited ServerStar Menu."
translations["en,press_key"]="Press any key to return to menu..."

# Persian/Farsi translations
translations["fa,menu_title"]="منوی سرور استار"
translations["fa,exit_message"]="از منوی سرور استار خارج شدید."
translations["fa,press_key"]="برای بازگشت به منو، هر کلیدی را فشار دهید..."

# Function to get translated string
get_text() {
  local key="$LANGUAGE,$1"
  echo "${translations[$key]:-$1}"
}

# Banner
print_banner() {
  clear
  echo -e "$cyan"
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
                     Project: PANEL STAR v1.2.0
EOF
  echo -e "$reset"
  sleep 1
}

# Error handling function
check_error() {
  if [ $? -ne 0 ]; then
    echo -e "${red}ERROR: $1${reset}"
    read -n1 -rp "$(get_text "press_key")"
    return 1
  fi
  return 0
}

# Install required dependencies
install_dependencies() {
  local dependencies=("$@")
  local missing_deps=()
  
  # Check for missing dependencies
  for dep in "${dependencies[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
      missing_deps+=("$dep")
    fi
  done
  
  # Install missing dependencies
  if [ ${#missing_deps[@]} -gt 0 ]; then
    echo -e "${yellow}Installing required dependencies: ${missing_deps[*]}${reset}"
    apt-get update || return 1
    apt-get install -y "${missing_deps[@]}" || return 1
    echo -e "${green}All dependencies installed successfully.${reset}"
  fi
  
  return 0
}

# Main menu
print_menu() {
  clear
  echo -e "${blue}==================== $(get_text "menu_title") ====================${reset}"
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
  echo -e "16. Install RPTraefik Tunnel ${yellow}[NEW]${reset}"
  echo -e "17. Install WARP Socks5 Proxy ${yellow}[NEW]${reset}"
  echo -e "18. Get Local IPv6 from Website ${yellow}[NEW]${reset}"
  echo -e "${green}19. Check Services Status ${yellow}[NEW]${reset}"
  echo -e "${green}20. Backup & Restore Menu ${yellow}[NEW]${reset}"
  echo -e "${green}21. Uninstall Menu ${yellow}[NEW]${reset}"
  echo -e "${green}22. Monitor System Resources ${yellow}[NEW]${reset}"
  echo -e "${green}23. Security Menu ${yellow}[NEW]${reset}"
  echo -e "${green}24. Install Sing-Box Core ${yellow}[NEW]${reset}"
  echo -e "${green}25. REALITY Protocol Setup ${yellow}[NEW]${reset}"
  echo -e "${green}26. Cloudflare Argo Tunnel ${yellow}[NEW]${reset}"
  echo -e "${green}27. Install Rathole Tunnel ${yellow}[NEW]${reset}"
  echo -e "${green}28. Install Marzban Panel ${yellow}[NEW]${reset}"
  echo -e "${green}29. Check for Script Updates ${yellow}[NEW]${reset}"
  echo -e "30. Exit"
  echo -ne "\nSelect an option: "
}

# Original functions
update_server_and_prereqs() {
  echo -e "${yellow}Updating system and installing prerequisites...${reset}"
  
  apt-get update || { check_error "Failed to update repository"; return; }
  apt-get upgrade -y || { check_error "Failed to upgrade packages"; return; }
  apt-get dist-upgrade -y || { check_error "Failed to perform distribution upgrade"; return; }
  
  # Install common tools and requirements
  install_dependencies curl wget socat unzip lsof iptables cron jq || { check_error "Failed to install dependencies"; return; }
  
  echo -e "${green}System updated successfully.${reset}"
  read -n1 -rp "$(get_text "press_key")"
}

obtain_ssl_certificate() {
  read -p "Enter your domain (e.g. host.example.com): " domain
  read -p "Enter your email address: " email
  
  echo -e "${yellow}Installing acme.sh and requesting certificate...${reset}"
  
  install_dependencies curl socat || { check_error "Failed to install dependencies"; return; }
  
  curl https://get.acme.sh | sh || { check_error "Failed to install acme.sh"; return; }
  ~/.acme.sh/acme.sh --set-default-ca --server letsencrypt || { check_error "Failed to set default CA"; return; }
  ~/.acme.sh/acme.sh --register-account -m "$email" || { check_error "Failed to register account"; return; }
  ~/.acme.sh/acme.sh --issue -d "$domain" --standalone || { check_error "Failed to issue certificate"; return; }
  
  ~/.acme.sh/acme.sh --installcert -d "$domain" \
    --key-file /root/private.key \
    --fullchain-file /root/cert.crt || { check_error "Failed to install certificate"; return; }
  
  echo -e "${green}SSL Certificate installed for $domain.${reset}"
  echo -e "${yellow}Certificate files:${reset}"
  echo -e "  Private Key: ${green}/root/private.key${reset}"
  echo -e "  Certificate: ${green}/root/cert.crt${reset}"
  
  # Create renewal cron job
  echo -e "${yellow}Setting up automatic renewal...${reset}"
  crontab -l | grep -q "acme.sh" || (crontab -l 2>/dev/null; echo "0 3 * * * ~/.acme.sh/acme.sh --cron --home ~/.acme.sh > /dev/null") | crontab -
  
  read -n1 -rp "$(get_text "press_key")"
}

install_mhsanaei_xui() {
  echo -e "${green}Installing MHSanaei X-UI...${reset}"
  echo -e "${yellow}This is one of the most maintained and updated X-UI panels in 2025, recommended for most users.${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
  check_error "Failed to install MHSanaei X-UI"
}

install_txui() {
  echo -e "${green}Installing TX-UI Panel...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/AghayeCoder/tx-ui/master/install.sh)
  check_error "Failed to install TX-UI Panel"
}

install_alireza_xui() {
  echo -e "${green}Installing Alireza X-UI v1.8.9...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/alireza0/x-ui/master/install.sh)
  check_error "Failed to install Alireza X-UI"
}

install_txui_theme() {
  echo -e "${green}Installing TX-UI Theme...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/AghayeCoder/tx-themehub/master/install.sh)
  check_error "Failed to install TX-UI Theme"
}

install_backup_script() {
  echo -e "${green}Installing Auto Backup Script...${reset}"
  bash <(curl -Ls https://github.com/AC-Lover/backup/raw/main/backup.sh)
  check_error "Failed to install Auto Backup Script"
}

install_haproxy_tunnel() {
  echo -e "${green}Installing Haproxy Tunnel...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/dev-ir/HAProxy/master/main.sh)
  check_error "Failed to install Haproxy Tunnel"
}

install_nebula() {
  echo -e "${green}Installing Nebula Tunnel...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/MrAminiDev/NebulaTunnel/main/install.sh)
  check_error "Failed to install Nebula Tunnel"
}

optimize_xray_warp() {
  echo -e "${green}Installing Xray Optimizer with WARP...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/dev-ir/Xray-WARP-Optimizer/main/install.sh)
  check_error "Failed to install Xray Optimizer with WARP"
}

setup_telegram_monitor() {
  echo -e "${yellow}Installing Telegram Monitor...${reset}"
  bash <(curl -Ls https://raw.githubusercontent.com/dev-ir/Telegram-Monitor/main/install.sh)
  check_error "Failed to install Telegram Monitor"
}

check_location() {
  echo -e "${yellow}Detecting server location...${reset}"
  
  install_dependencies curl || { check_error "Failed to install curl"; return; }
  
  country=$(curl -s https://ipinfo.io/country)
  ip=$(curl -s https://ipinfo.io/ip)
  asn=$(curl -s https://ipinfo.io/org)
  
  echo -e "\n${blue}Server Information:${reset}"
  echo -e "IP: ${green}$ip${reset}"
  echo -e "Location: ${green}$country${reset}"
  echo -e "ASN: ${green}$asn${reset}"
  
  read -n1 -rp "$(get_text "press_key")"
}

generate_ipv6() {
  echo -e "${yellow}Generating random local IPv6 (fd00::/8)...${reset}"
  echo -e "${blue}Generated IPv6 addresses:${reset}"
  
  for i in {1..5}; do
    printf "fd%02x:%04x:%04x:%04x::/64\n" $((RANDOM%256)) $((RANDOM%65536)) $((RANDOM%65536)) $((RANDOM%65536))
  done
  
  read -n1 -rp "$(get_text "press_key")"
}

manual_tunnel_setup() {
  read -p $'Enter Server IPv4: ' ipv4
  read -p $'Enter Server IPv6 (without ::): ' ipv6
  
  echo -e "\n${blue}Manual Tunnel Info:${reset}"
  echo -e "IPv4: ${green}$ipv4${reset}"
  echo -e "IPv6: ${green}$ipv6::1${reset}"
  echo -e "\n${yellow}Usage Notes:${reset}"
  echo -e "- Use with GOST, Rathole, or other tunneling solutions"
  echo -e "- For GOST tunneling: gost -L=tcp://:PortNumber -F=tcp://$ipv6::1:PortNumber"
  echo -e "- For Rathole client config, use '$ipv6::1' as server address"
  
  read -n1 -rp "$(get_text "press_key")"
}

fix_warp_fscarmen() {
    echo -e "${yellow}Installing WARP (fscarmen)...${reset}"
    
    install_dependencies wget bc || { check_error "Failed to install dependencies"; return; }
    
    wget -N https://gitlab.com/fscarmen/warp/-/raw/main/menu.sh || { check_error "Failed to download WARP script"; return; }
    bash menu.sh

    CONFIG_FILE="/etc/wireguard/proxy.conf"
    NEW_ENDPOINT="engage.cloudflareclient.com:2408"

    if [ -f "$CONFIG_FILE" ]; then
        echo -e "${yellow}Optimizing $CONFIG_FILE configuration...${reset}"
        sed -i '/^Endpoint = /c\Endpoint = '"$NEW_ENDPOINT" "$CONFIG_FILE"
        sed -i '/^$/d' "$CONFIG_FILE"  # Remove empty lines
    else
        echo -e "${red}File proxy.conf not found. Operation canceled.${reset}"
        read -n1 -rp "$(get_text "press_key")"
        return
    fi

    echo -e "${yellow}Running warp y to reconnect...${reset}"
    warp y

    echo -e "${yellow}Creating wireproxy RAM usage monitor script...${reset}"
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

    echo -e "${yellow}Creating wireproxy RAM monitor service...${reset}"
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

    echo -e "\n${green}✅ Operation completed successfully. wireproxy RAM monitor service is active.${reset}"
    read -n1 -rp "$(get_text "press_key")"
}

# Previously added functions
install_rptraefik() {
    echo -e "${yellow}Installing RPTraefik Tunnel...${reset}"
    echo -e "This will install RPTraefik Tunnel from dev-ir repository."
    
    install_dependencies git || { check_error "Failed to install git"; return; }
    
    echo -e "${yellow}Cloning RPTraefik repository and starting installation...${reset}"
    sudo git clone https://github.com/dev-ir/RPTraefik.git /opt/RPTraefik || { check_error "Failed to clone repository"; return; }
    cd /opt/RPTraefik && bash main.sh
    
    echo -e "${green}RPTraefik Tunnel installation completed.${reset}"
    read -n1 -rp "$(get_text "press_key")"
}

install_warp_socks5() {
    echo -e "${yellow}Installing WARP Socks5 Proxy...${reset}"
    echo -e "This will install WARP Socks5 Proxy on port 40000."
    
    # Install WARP Socks5 Proxy
    bash <(curl -sSL https://raw.githubusercontent.com/hamid-gh98/x-ui-scripts/main/install_warp_proxy.sh)
    check_error "Failed to install WARP Socks5 Proxy"
    
    echo -e "\n${green}WARP Socks5 Proxy has been installed.${reset}"
    echo -e "\n${yellow}Configuration Instructions for X-UI:${reset}"
    echo -e "1. Add the following at the end of your outbounds section:"
    echo -e "${blue}"
    echo '{
  "tag": "WARP",
  "protocol": "socks",
  "settings": {
    "servers": [
      {
        "address": "127.0.0.1",
        "port": 40000
      }
    ]
  }
}'
    echo -e "${reset}"
    
    echo -e "2. Add the following at the end of your routing rules:"
    echo -e "${blue}"
    echo '{
  "type": "field",
  "outboundTag": "WARP",
  "domain": [
    "cloudflare.com",
    "iran.ir"
  ]
}'
    echo -e "${reset}"
    
    echo -e "${yellow}NOTE: To use WARP+, run 'warp a' and select option 2.${reset}"
    
    read -n1 -rp "$(get_text "press_key")"
}

get_online_ipv6() {
    echo -e "${yellow}Fetching Local IPv6 from unique-local-ipv6.com...${reset}"
    
    install_dependencies curl || { check_error "Failed to install curl"; return; }
    
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
    
    read -n1 -rp "$(get_text "press_key")"
}

# New services status function
check_services_status() {
    clear
    echo -e "${blue}==================== Services Status ====================${reset}"
    
    # Check X-UI status
    if systemctl is-active --quiet x-ui &>/dev/null; then
        echo -e "X-UI: ${green}Active${reset}"
        x_ui_port=$(grep "port" /usr/local/x-ui/bin/config.json 2>/dev/null | grep -o '[0-9]\+' | head -1)
        if [ -n "$x_ui_port" ]; then
            echo -e "  Port: ${green}$x_ui_port${reset}"
        fi
    else
        echo -e "X-UI: ${red}Inactive${reset}"
    fi
    
    # Check if Sing-Box is installed and running
    if command -v sing-box &>/dev/null; then
        if systemctl is-active --quiet sing-box &>/dev/null; then
            echo -e "Sing-Box: ${green}Active${reset}"
        else
            echo -e "Sing-Box: ${red}Inactive${reset}"
        fi
    else
        echo -e "Sing-Box: ${red}Not Installed${reset}"
    fi
    
    # Check if Marzban is installed and running
    if [ -d "/opt/marzban" ]; then
        if systemctl is-active --quiet marzban &>/dev/null; then
            echo -e "Marzban: ${green}Active${reset}"
            # Try to get Marzban port
            marzban_port=$(grep -r "listen.*:" /opt/marzban/docker-compose.yml 2>/dev/null | grep -o '[0-9]\+:' | head -1 | tr -d ':')
            if [ -n "$marzban_port" ]; then
                echo -e "  Port: ${green}$marzban_port${reset}"
            fi
        else
            echo -e "Marzban: ${red}Inactive${reset}"
        fi
    else
        echo -e "Marzban: ${red}Not Installed${reset}"
    fi
    
    # Check WARP status
    if command -v warp &>/dev/null; then
        if warp s 2>/dev/null | grep -q "Status: Connected"; then
            echo -e "WARP: ${green}Connected${reset}"
            warp_ip=$(warp s 2>/dev/null | grep "WAN" | awk '{print $NF}')
            if [ -n "$warp_ip" ]; then
                echo -e "  WARP IP: ${green}$warp_ip${reset}"
            fi
        else
            echo -e "WARP: ${red}Disconnected${reset}"
        fi
    else
        echo -e "WARP: ${red}Not Installed${reset}"
    fi
    
    # Check WARP Socks5 status
    if lsof -i:40000 &>/dev/null; then
        echo -e "WARP Socks5 (Port 40000): ${green}Active${reset}"
    else
        echo -e "WARP Socks5 (Port 40000): ${red}Inactive${reset}"
    fi
    
    # Check tunnels status
    echo -e "\n${blue}Tunnel Services:${reset}"
    
    # Check HAProxy status
    if systemctl is-active --quiet haproxy &>/dev/null; then
        echo -e "HAProxy Tunnel: ${green}Active${reset}"
    else
        echo -e "HAProxy Tunnel: ${red}Inactive${reset}"
    fi
    
    # Check RPTraefik status
    if [ -f "/opt/RPTraefik/rptraefik.service" ] && systemctl is-active --quiet rptraefik &>/dev/null; then
        echo -e "RPTraefik Tunnel: ${green}Active${reset}"
    else
        echo -e "RPTraefik Tunnel: ${red}Inactive${reset}"
    fi
    
    # Check Nebula status
    if systemctl is-active --quiet nebula &>/dev/null; then
        echo -e "Nebula Tunnel: ${green}Active${reset}"
    else
        echo -e "Nebula Tunnel: ${red}Inactive${reset}"
    fi
    
    # Check Rathole status
    if pgrep -x "rathole" >/dev/null; then
        echo -e "Rathole Tunnel: ${green}Active${reset}"
    else
        echo -e "Rathole Tunnel: ${red}Inactive${reset}"
    fi
    
    # Check Cloudflare Argo status
    if pgrep -x "cloudflared" >/dev/null; then
        echo -e "Cloudflare Argo Tunnel: ${green}Active${reset}"
    else
        echo -e "Cloudflare Argo Tunnel: ${red}Inactive${reset}"
    fi
    
    echo -e "${blue}=======================================================${reset}"
    read -n1 -rp "$(get_text "press_key")"
}

# Backup & Restore Menu
print_backup_menu() {
    clear
    echo -e "${blue}==================== Backup & Restore Menu ====================${reset}"
    echo -e "1. Backup All Configurations"
    echo -e "2. Backup X-UI Configuration"
    echo -e "3. Backup Tunnel Configurations"
    echo -e "4. Restore from Backup"
    echo -e "5. Return to Main Menu"
    echo -ne "\nSelect an option: "
}

backup_all() {
    echo -e "${yellow}Creating system backup...${reset}"
    
    # Create backup directory with timestamp
    backup_dir="/root/backups/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir" || { check_error "Failed to create backup directory"; return; }
    
    echo -e "Backup directory created: ${green}$backup_dir${reset}"
    
    # Backup X-UI configuration
    if [ -d "/usr/local/x-ui" ]; then
        echo -e "${yellow}Backing up X-UI configuration...${reset}"
        mkdir -p "$backup_dir/x-ui"
        if [ -f "/usr/local/x-ui/bin/config.json" ]; then
            cp "/usr/local/x-ui/bin/config.json" "$backup_dir/x-ui/" || echo -e "${red}Failed to backup X-UI config.json${reset}"
        fi
        if [ -d "/usr/local/x-ui/bin/config" ]; then
            cp -r "/usr/local/x-ui/bin/config" "$backup_dir/x-ui/" || echo -e "${red}Failed to backup X-UI config directory${reset}"
        fi
        if [ -d "/usr/local/x-ui/db" ]; then
            cp -r "/usr/local/x-ui/db" "$backup_dir/x-ui/" || echo -e "${red}Failed to backup X-UI database${reset}"
        fi
        echo -e "${green}X-UI configuration backed up.${reset}"
    fi
    
    # Backup Sing-Box configuration
    if [ -d "/etc/sing-box" ]; then
        echo -e "${yellow}Backing up Sing-Box configuration...${reset}"
        mkdir -p "$backup_dir/sing-box"
        cp -r "/etc/sing-box" "$backup_dir/" || echo -e "${red}Failed to backup Sing-Box configuration${reset}"
        echo -e "${green}Sing-Box configuration backed up.${reset}"
    fi
    
    # Backup Marzban configuration
    if [ -d "/opt/marzban" ]; then
        echo -e "${yellow}Backing up Marzban configuration...${reset}"
        mkdir -p "$backup_dir/marzban"
        cp -r "/opt/marzban" "$backup_dir/" || echo -e "${red}Failed to backup Marzban configuration${reset}"
        echo -e "${green}Marzban configuration backed up.${reset}"
    fi
    
    # Backup WARP configuration
    if [ -f "/etc/wireguard/wgcf.conf" ]; then
        echo -e "${yellow}Backing up WARP configuration...${reset}"
        mkdir -p "$backup_dir/warp"
        cp "/etc/wireguard/wgcf.conf" "$backup_dir/warp/" || echo -e "${red}Failed to backup WARP configuration${reset}"
        if [ -f "/etc/wireguard/proxy.conf" ]; then
            cp "/etc/wireguard/proxy.conf" "$backup_dir/warp/" || echo -e "${red}Failed to backup WARP proxy configuration${reset}"
        fi
        echo -e "${green}WARP configuration backed up.${reset}"
    fi
    
    # Backup HAProxy configuration
    if [ -f "/etc/haproxy/haproxy.cfg" ]; then
        echo -e "${yellow}Backing up HAProxy configuration...${reset}"
        mkdir -p "$backup_dir/haproxy"
        cp "/etc/haproxy/haproxy.cfg" "$backup_dir/haproxy/" || echo -e "${red}Failed to backup HAProxy configuration${reset}"
        echo -e "${green}HAProxy configuration backed up.${reset}"
    fi
    
    # Backup RPTraefik configuration
    if [ -d "/opt/RPTraefik" ]; then
        echo -e "${yellow}Backing up RPTraefik configuration...${reset}"
        mkdir -p "$backup_dir/rptraefik"
        cp -r "/opt/RPTraefik/config" "$backup_dir/rptraefik/" 2>/dev/null || echo -e "${red}Failed to backup RPTraefik configuration${reset}"
        echo -e "${green}RPTraefik configuration backed up.${reset}"
    fi
    
    # Backup Nebula configuration
    if [ -d "/etc/nebula" ]; then
        echo -e "${yellow}Backing up Nebula configuration...${reset}"
        mkdir -p "$backup_dir/nebula"
        cp -r "/etc/nebula" "$backup_dir/nebula/" || echo -e "${red}Failed to backup Nebula configuration${reset}"
        echo -e "${green}Nebula configuration backed up.${reset}"
    fi
    
    # Backup Rathole configuration
    if [ -f "/etc/rathole/config.toml" ]; then
        echo -e "${yellow}Backing up Rathole configuration...${reset}"
        mkdir -p "$backup_dir/rathole"
        cp "/etc/rathole/config.toml" "$backup_dir/rathole/" || echo -e "${red}Failed to backup Rathole configuration${reset}"
        echo -e "${green}Rathole configuration backed up.${reset}"
    fi
    
    # Backup Cloudflare Argo configuration
    if [ -d "/etc/cloudflared" ]; then
        echo -e "${yellow}Backing up Cloudflare Argo configuration...${reset}"
        mkdir -p "$backup_dir/cloudflared"
        cp -r "/etc/cloudflared" "$backup_dir/cloudflared/" || echo -e "${red}Failed to backup Cloudflare Argo configuration${reset}"
        echo -e "${green}Cloudflare Argo configuration backed up.${reset}"
    fi
    
    # Create backup archive
    echo -e "${yellow}Creating backup archive...${reset}"
    tar -czf "${backup_dir}.tar.gz" -C "$(dirname "$backup_dir")" "$(basename "$backup_dir")" || { check_error "Failed to create backup archive"; return; }
    
    # Remove the directory to save space, keep only the archive
    rm -rf "$backup_dir"
    
    echo -e "\n${green}Backup completed successfully!${reset}"
    echo -e "Backup file: ${green}${backup_dir}.tar.gz${reset}"
    echo -e "Note: To restore from backup, use: tar -xzf ${backup_dir}.tar.gz -C /"
    
    read -n1 -rp "$(get_text "press_key")"
}

backup_xui() {
    echo -e "${yellow}Backing up X-UI configuration...${reset}"
    
    if [ ! -d "/usr/local/x-ui" ]; then
        echo -e "${red}X-UI not installed. Nothing to backup.${reset}"
        read -n1 -rp "$(get_text "press_key")"
        return
    fi
    
    # Create backup directory with timestamp
    backup_dir="/root/backups/xui_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir" || { check_error "Failed to create backup directory"; return; }
    
    echo -e "Backup directory created: ${green}$backup_dir${reset}"
    
    # Backup X-UI configuration
    mkdir -p "$backup_dir/x-ui"
    if [ -f "/usr/local/x-ui/bin/config.json" ]; then
        cp "/usr/local/x-ui/bin/config.json" "$backup_dir/x-ui/" || echo -e "${red}Failed to backup X-UI config.json${reset}"
    fi
    if [ -d "/usr/local/x-ui/bin/config" ]; then
        cp -r "/usr/local/x-ui/bin/config" "$backup_dir/x-ui/" || echo -e "${red}Failed to backup X-UI config directory${reset}"
    fi
    if [ -d "/usr/local/x-ui/db" ]; then
        cp -r "/usr/local/x-ui/db" "$backup_dir/x-ui/" || echo -e "${red}Failed to backup X-UI database${reset}"
    fi
    
    # Create backup archive
    echo -e "${yellow}Creating backup archive...${reset}"
    tar -czf "${backup_dir}.tar.gz" -C "$(dirname "$backup_dir")" "$(basename "$backup_dir")" || { check_error "Failed to create backup archive"; return; }
    
    # Remove the directory to save space, keep only the archive
    rm -rf "$backup_dir"
    
    echo -e "\n${green}X-UI backup completed successfully!${reset}"
    echo -e "Backup file: ${green}${backup_dir}.tar.gz${reset}"
    
    read -n1 -rp "$(get_text "press_key")"
}

backup_tunnels() {
    echo -e "${yellow}Backing up tunnel configurations...${reset}"
    
    # Create backup directory with timestamp
    backup_dir="/root/backups/tunnels_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir" || { check_error "Failed to create backup directory"; return; }
    
    echo -e "Backup directory created: ${green}$backup_dir${reset}"
    
    # Backup HAProxy configuration
    if [ -f "/etc/haproxy/haproxy.cfg" ]; then
        echo -e "${yellow}Backing up HAProxy configuration...${reset}"
        mkdir -p "$backup_dir/haproxy"
        cp "/etc/haproxy/haproxy.cfg" "$backup_dir/haproxy/" || echo -e "${red}Failed to backup HAProxy configuration${reset}"
        echo -e "${green}HAProxy configuration backed up.${reset}"
    fi
    
    # Backup RPTraefik configuration
    if [ -d "/opt/RPTraefik" ]; then
        echo -e "${yellow}Backing up RPTraefik configuration...${reset}"
        mkdir -p "$backup_dir/rptraefik"
        cp -r "/opt/RPTraefik/config" "$backup_dir/rptraefik/" 2>/dev/null || echo -e "${red}Failed to backup RPTraefik configuration${reset}"
        echo -e "${green}RPTraefik configuration backed up.${reset}"
    fi
    
    # Backup Nebula configuration
    if [ -d "/etc/nebula" ]; then
        echo -e "${yellow}Backing up Nebula configuration...${reset}"
        mkdir -p "$backup_dir/nebula"
        cp -r "/etc/nebula" "$backup_dir/nebula/" || echo -e "${red}Failed to backup Nebula configuration${reset}"
        echo -e "${green}Nebula configuration backed up.${reset}"
    fi
    
    # Backup Rathole configuration
    if [ -f "/etc/rathole/config.toml" ]; then
        echo -e "${yellow}Backing up Rathole configuration...${reset}"
        mkdir -p "$backup_dir/rathole"
        cp "/etc/rathole/config.toml" "$backup_dir/rathole/" || echo -e "${red}Failed to backup Rathole configuration${reset}"
        echo -e "${green}Rathole configuration backed up.${reset}"
    fi
    
    # Backup Cloudflare Argo configuration
    if [ -d "/etc/cloudflared" ]; then
        echo -e "${yellow}Backing up Cloudflare Argo configuration...${reset}"
        mkdir -p "$backup_dir/cloudflared"
        cp -r "/etc/cloudflared" "$backup_dir/cloudflared/" || echo -e "${red}Failed to backup Cloudflare Argo configuration${reset}"
        echo -e "${green}Cloudflare Argo configuration backed up.${reset}"
    fi
    
    # Create backup archive
    echo -e "${yellow}Creating backup archive...${reset}"
    tar -czf "${backup_dir}.tar.gz" -C "$(dirname "$backup_dir")" "$(basename "$backup_dir")" || { check_error "Failed to create backup archive"; return; }
    
    # Remove the directory to save space, keep only the archive
    rm -rf "$backup_dir"
    
    echo -e "\n${green}Tunnel configurations backup completed successfully!${reset}"
    echo -e "Backup file: ${green}${backup_dir}.tar.gz${reset}"
    
    read -n1 -rp "$(get_text "press_key")"
}

restore_backup() {
    echo -e "${yellow}Restore from backup...${reset}"
    
    # List available backups
    echo -e "${blue}Available backups:${reset}"
    
    backup_files=( /root/backups/*.tar.gz )
    if [ ${#backup_files[@]} -eq 0 ] || [ ! -f "${backup_files[0]}" ]; then
        echo -e "${red}No backup files found in /root/backups/. Operation canceled.${reset}"
        read -n1 -rp "$(get_text "press_key")"
        return
    fi
    
    for i in "${!backup_files[@]}"; do
        echo -e "$((i+1)). ${green}$(basename "${backup_files[$i]}")${reset}"
    done
    
    # Select backup file
    read -p "Select backup to restore (number): " selection
    
    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt ${#backup_files[@]} ]; then
        echo -e "${red}Invalid selection. Operation canceled.${reset}"
        read -n1 -rp "$(get_text "press_key")"
        return
    fi
    
    selected_backup="${backup_files[$((selection-1))]}"
    echo -e "${yellow}Selected backup: ${green}$(basename "$selected_backup")${reset}"
    
    # Confirm restoration
    read -p "WARNING: This will overwrite existing configurations. Continue? (y/n): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${yellow}Restoration canceled.${reset}"
        read -n1 -rp "$(get_text "press_key")"
        return
    fi
    
    # Extract backup
    echo -e "${yellow}Extracting backup...${reset}"
    temp_dir="/tmp/restore_$$"
    mkdir -p "$temp_dir"
    
    tar -xzf "$selected_backup" -C "$temp_dir" || { 
        check_error "Failed to extract backup"
        rm -rf "$temp_dir"
        return
    }
    
    # Find the extracted directory
    extracted_dir=$(find "$temp_dir" -mindepth 1 -maxdepth 1 -type d | head -1)
    
    if [ -z "$extracted_dir" ]; then
        echo -e "${red}Invalid backup structure. Operation canceled.${reset}"
        rm -rf "$temp_dir"
        read -n1 -rp "$(get_text "press_key")"
        return
    fi
    
    # Restore configurations based on what's in the backup
    if [ -d "$extracted_dir/x-ui" ]; then
        echo -e "${yellow}Restoring X-UI configuration...${reset}"
        
        # Stop X-UI service if running
        if systemctl is-active --quiet x-ui; then
            systemctl stop x-ui
        fi
        
        # Restore config.json
        if [ -f "$extracted_dir/x-ui/config.json" ] && [ -d "/usr/local/x-ui/bin" ]; then
            cp "$extracted_dir/x-ui/config.json" "/usr/local/x-ui/bin/" || echo -e "${red}Failed to restore X-UI config.json${reset}"
        fi
        
        # Restore config directory
        if [ -d "$extracted_dir/x-ui/config" ] && [ -d "/usr/local/x-ui/bin" ]; then
            cp -r "$extracted_dir/x-ui/config" "/usr/local/x-ui/bin/" || echo -e "${red}Failed to restore X-UI config directory${reset}"
        fi
        
        # Restore database
        if [ -d "$extracted_dir/x-ui/db" ] && [ -d "/usr/local/x-ui" ]; then
            cp -r "$extracted_dir/x-ui/db" "/usr/local/x-ui/" || echo -e "${red}Failed to restore X-UI database${reset}"
        fi
        
        # Start X-UI service
        if systemctl is-enabled --quiet x-ui; then
            systemctl start x-ui
        fi
        
        echo -e "${green}X-UI configuration restored.${reset}"
    fi
    
    # Restore HAProxy configuration
    if [ -d "$extracted_dir/haproxy" ] && [ -f "$extracted_dir/haproxy/haproxy.cfg" ]; then
        echo -e "${yellow}Restoring HAProxy configuration...${reset}"
        
        # Stop HAProxy service if running
        if systemctl is-active --quiet haproxy; then
            systemctl stop haproxy
        fi
        
        cp "$extracted_dir/haproxy/haproxy.cfg" "/etc/haproxy/" || echo -e "${red}Failed to restore HAProxy configuration${reset}"
        
        # Start HAProxy service
        if systemctl is-enabled --quiet haproxy; then
            systemctl start haproxy
        fi
        
        echo -e "${green}HAProxy configuration restored.${reset}"
    fi
    
    # Restore RPTraefik configuration
    if [ -d "$extracted_dir/rptraefik" ] && [ -d "$extracted_dir/rptraefik/config" ]; then
        echo -e "${yellow}Restoring RPTraefik configuration...${reset}"
        
        # Stop RPTraefik service if running
        if systemctl is-active --quiet rptraefik; then
            systemctl stop rptraefik
        fi
        
        if [ -d "/opt/RPTraefik" ]; then
            cp -r "$extracted_dir/rptraefik/config" "/opt/RPTraefik/" || echo -e "${red}Failed to restore RPTraefik configuration${reset}"
        fi
        
        # Start RPTraefik service
        if systemctl is-enabled --quiet rptraefik; then
            systemctl start rptraefik
        fi
        
        echo -e "${green}RPTraefik configuration restored.${reset}"
    fi
    
    # Add more restoration logic for other services as needed
    
    # Clean up
    rm -rf "$temp_dir"
    
    echo -e "\n${green}Restoration completed successfully!${reset}"
    read -n1 -rp "$(get_text "press_key")"
}

# Uninstall menu
print_uninstall_menu() {
    clear
    echo -e "${blue}==================== Uninstall Menu ====================${reset}"
    echo -e "1. Uninstall X-UI Panel"
    echo -e "2. Uninstall WARP"
    echo -e "3. Uninstall WARP Socks5"
    echo -e "4. Uninstall HAProxy Tunnel"
    echo -e "5. Uninstall RPTraefik Tunnel"
    echo -e "6. Uninstall Nebula Tunnel"
    echo -e "7. Uninstall Rathole Tunnel"
    echo -e "8. Uninstall Cloudflare Argo Tunnel"
    echo -e "9. Uninstall Sing-Box"
    echo -e "10. Uninstall Marzban Panel"
    echo -e "11. Return to Main Menu"
    echo -ne "\nSelect an option: "
}

uninstall_xui() {
    echo -e "${yellow}Uninstalling X-UI Panel...${reset}"
    
    if [ -f "/usr/local/x-ui/x-ui.sh" ]; then
        /usr/local/x-ui/x-ui.sh uninstall
        check_error "Failed to uninstall X-UI Panel"
    else
        echo -e "${red}X-UI Panel not found or already uninstalled.${reset}"
    fi
    
    read -n1 -rp "$(get_text "press_key")"
}

uninstall_warp() {
    echo -e "${yellow}Uninstalling WARP...${reset}"
    
    if command -v warp &>/dev/null; then
        warp u
        check_error "Failed to uninstall WARP"
    else
        echo -e "${red}WARP not found or already uninstalled.${reset}"
    fi
    
    # Clean up WARP monitor service if it exists
    if [ -f "/etc/systemd/system/monitor-wireproxy.service" ]; then
        echo -e "${yellow}Removing WARP monitor service...${reset}"
        systemctl stop monitor-wireproxy
        systemctl disable monitor-wireproxy
        rm -f /etc/systemd/system/monitor-wireproxy.service
        rm -f /root/monitor_wireproxy.sh
        systemctl daemon-reload
    fi
    
    read -n1 -rp "$(get_text "press_key")"
}

uninstall_warp_socks5() {
    echo -e "${yellow}Uninstalling WARP Socks5 Proxy...${reset}"
    
    if systemctl is-active --quiet warp-svc; then
        systemctl stop warp-svc
        systemctl disable warp-svc
        
        if command -v warp-cli &>/dev/null; then
            warp-cli disconnect
            warp-cli disable-always-on
            warp-cli delete
        fi
        
        # Remove WARP packages
        apt-get remove -y cloudflare-warp || true
        
        echo -e "${green}WARP Socks5 Proxy has been uninstalled.${reset}"
    else
        echo -e "${red}WARP Socks5 Proxy not found or already uninstalled.${reset}"
    fi
    
    read -n1 -rp "$(get_text "press_key")"
}

uninstall_haproxy() {
    echo -e "${yellow}Uninstalling HAProxy Tunnel...${reset}"
    
    if systemctl is-active --quiet haproxy; then
        systemctl stop haproxy
        systemctl disable haproxy
        apt-get remove -y haproxy
        apt-get autoremove -y
        
        echo -e "${green}HAProxy Tunnel has been uninstalled.${reset}"
    else
        echo -e "${red}HAProxy Tunnel not found or already uninstalled.${reset}"
    fi
    
    read -n1 -rp "$(get_text "press_key")"
}

uninstall_rptraefik() {
    echo -e "${yellow}Uninstalling RPTraefik Tunnel...${reset}"
    
    if [ -d "/opt/RPTraefik" ]; then
        if [ -f "/opt/RPTraefik/uninstall.sh" ]; then
            bash /opt/RPTraefik/uninstall.sh
        else
            # Fallback if uninstall script doesn't exist
            if systemctl is-active --quiet rptraefik; then
                systemctl stop rptraefik
                systemctl disable rptraefik
            fi
            rm -rf /opt/RPTraefik
        fi
        
        echo -e "${green}RPTraefik Tunnel has been uninstalled.${reset}"
    else
        echo -e "${red}RPTraefik Tunnel not found or already uninstalled.${reset}"
    fi
    
    read -n1 -rp "$(get_text "press_key")"
}

uninstall_nebula() {
    echo -e "${yellow}Uninstalling Nebula Tunnel...${reset}"
    
    if systemctl is-active --quiet nebula; then
        systemctl stop nebula
        systemctl disable nebula
        
        # Remove Nebula files
        rm -rf /etc/nebula
        rm -f /usr/local/bin/nebula
        
        echo -e "${green}Nebula Tunnel has been uninstalled.${reset}"
    else
        echo -e "${red}Nebula Tunnel not found or already uninstalled.${reset}"
    fi
    
    read -n1 -rp "$(get_text "press_key")"
}

# System monitoring menu
print_monitor_menu() {
    clear
    echo -e "${blue}==================== System Monitoring ====================${reset}"
    echo -e "1. Monitor CPU Usage"
    echo -e "2. Monitor Memory Usage"
    echo -e "3. Monitor Disk Usage"
    echo -e "4. Monitor Network Traffic"
    echo -e "5. Monitor Active Connections"
    echo -e "6. Show System Info"
    echo -e "7. Return to Main Menu"
    echo -ne "\nSelect an option: "
}

monitor_cpu() {
    echo -e "${yellow}Monitoring CPU usage (press Ctrl+C to exit)...${reset}"
    top -bn 1 | head -20
    read -n1 -rp "$(get_text "press_key")"
}

monitor_memory() {
    echo -e "${yellow}Current Memory Usage:${reset}"
    free -h
    
    echo -e "\n${yellow}Top memory-consuming processes:${reset}"
    ps aux --sort=-%mem | head -11
    
    read -n1 -rp "$(get_text "press_key")"
}

monitor_disk() {
    echo -e "${yellow}Current Disk Usage:${reset}"
    df -h
    
    echo -e "\n${yellow}Largest directories in root:${reset}"
    du -h --max-depth=1 / 2>/dev/null | sort -hr | head -10
    
    read -n1 -rp "$(get_text "press_key")"
}

monitor_network() {
    echo -e "${yellow}Current Network Interfaces:${reset}"
    ip -c a
    
    echo -e "\n${yellow}Network Statistics:${reset}"
    netstat -tuln
    
    read -n1 -rp "$(get_text "press_key")"
}

monitor_connections() {
    echo -e "${yellow}Active connections (press Ctrl+C to exit)...${reset}"
    
    echo -e "\n${yellow}Active connections count per IP:${reset}"
    netstat -ntu | grep ESTABLISHED | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head -10
    
    echo -e "\n${yellow}Total active connections: ${green}$(netstat -ntu | grep ESTABLISHED | wc -l)${reset}"
    
    read -n1 -rp "$(get_text "press_key")"
}

show_system_info() {
    echo -e "${yellow}System Information:${reset}"
    
    # OS Info
    echo -e "\n${blue}OS Information:${reset}"
    cat /etc/os-release | grep -E "^(NAME|VERSION)="
    
    # CPU Info
    echo -e "\n${blue}CPU Information:${reset}"
    lscpu | grep -E "Model name|^CPU\(s\)"
    
    # Memory Info
    echo -e "\n${blue}Memory Information:${reset}"
    free -h | grep -E "Mem|Swap"
    
    # Disk Info
    echo -e "\n${blue}Disk Information:${reset}"
    df -h | grep -v "tmpfs"
    
    # Kernel Info
    echo -e "\n${blue}Kernel Information:${reset}"
    uname -a
    
    # Uptime
    echo -e "\n${blue}System Uptime:${reset}"
    uptime
    
    read -n1 -rp "$(get_text "press_key")"
}

# Security menu
print_security_menu() {
    clear
    echo -e "${blue}==================== Security Menu ====================${reset}"
    echo -e "1. Change SSH Port"
    echo -e "2. Setup Basic Firewall"
    echo -e "3. Configure Fail2Ban"
    echo -e "4. Update SSL Certificate"
    echo -e "5. Return to Main Menu"
    echo -ne "\nSelect an option: "
}

change_ssh_port() {
    echo -e "${yellow}Changing SSH Port...${reset}"
    
    current_port=$(grep "^Port " /etc/ssh/sshd_config | awk '{print $2}')
    if [ -z "$current_port" ]; then
        current_port="22 (default)"
    fi
    
    echo -e "Current SSH port: ${green}$current_port${reset}"
    read -p "Enter new SSH port (1024-65535): " new_port
    
    # Validate port number
    if ! [[ "$new_port" =~ ^[0-9]+$ ]] || [ "$new_port" -lt 1024 ] || [ "$new_port" -gt 65535 ]; then
        echo -e "${red}Invalid port number. Must be between 1024 and 65535.${reset}"
        read -n1 -rp "$(get_text "press_key")"
        return
    fi
    
    # Backup sshd_config
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak.$(date +%Y%m%d%H%M%S)
    
    # Update SSH port
    if grep -q "^Port " /etc/ssh/sshd_config; then
        sed -i "s/^Port .*/Port $new_port/" /etc/ssh/sshd_config
    else
        echo "Port $new_port" >> /etc/ssh/sshd_config
    fi
    
    # Restart SSH service
    systemctl restart sshd
    
    echo -e "${green}SSH port changed to $new_port.${reset}"
    echo -e "${yellow}IMPORTANT: Make sure to connect using the new port from now on!${reset}"
    
    read -n1 -rp "$(get_text "press_key")"
}

setup_firewall() {
    echo -e "${yellow}Setting up basic firewall...${reset}"
    
    # Install ufw if not already installed
    if ! command -v ufw &>/dev/null; then
        echo -e "${yellow}Installing UFW firewall...${reset}"
        apt-get update
        apt-get install -y ufw
    fi
    
    # Reset UFW to default
    ufw --force reset
    
    # Set default policies
    ufw default deny incoming
    ufw default allow outgoing
    
    # Get current SSH port
    ssh_port=$(grep "^Port " /etc/ssh/sshd_config | awk '{print $2}')
    if [ -z "$ssh_port" ]; then
        ssh_port=22
    fi
    
    # Allow SSH
    ufw allow $ssh_port/tcp
    
    # Get X-UI port if installed
    x_ui_port=$(grep "port" /usr/local/x-ui/bin/config.json 2>/dev/null | grep -o '[0-9]\+' | head -1)
    if [ -n "$x_ui_port" ]; then
        echo -e "${yellow}Allowing X-UI panel port: $x_ui_port${reset}"
        ufw allow $x_ui_port/tcp
    fi
    
    # Allow common ports
    echo -e "${yellow}Allowing common ports: 80/tcp (HTTP), 443/tcp (HTTPS)${reset}"
    ufw allow 80/tcp
    ufw allow 443/tcp
    
    # Enable UFW
    echo -e "${yellow}Enabling UFW...${reset}"
    ufw --force enable
    
    echo -e "${green}Basic firewall setup completed.${reset}"
    echo -e "Allowed ports: SSH ($ssh_port/tcp), HTTP (80/tcp), HTTPS (443/tcp)"
    if [ -n "$x_ui_port" ]; then
        echo -e "              X-UI Panel ($x_ui_port/tcp)"
    fi
    
    read -n1 -rp "$(get_text "press_key")"
}

configure_fail2ban() {
    echo -e "${yellow}Installing and configuring Fail2Ban...${reset}"
    
    # Install Fail2Ban
    apt-get update
    apt-get install -y fail2ban
    
    # Create custom SSH jail config
    cat > /etc/fail2ban/jail.d/sshd.conf << EOF
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
findtime = 300
bantime = 3600
EOF
    
    # Restart Fail2Ban
    systemctl restart fail2ban
    
    echo -e "${green}Fail2Ban has been configured to protect SSH.${reset}"
    echo -e "Settings:"
    echo -e "  - Max retries: 5"
    echo -e "  - Find time: 300 seconds (5 minutes)"
    echo -e "  - Ban time: 3600 seconds (1 hour)"
    
    read -n1 -rp "$(get_text "press_key")"
}

# Install Sing-Box Core function
install_singbox() {
    echo -e "${yellow}Installing Sing-Box Core...${reset}"
    
    # Install dependencies
    install_dependencies curl jq || { check_error "Failed to install dependencies"; return; }
    
    # Get the latest version from GitHub
    echo -e "${yellow}Getting latest Sing-Box version...${reset}"
    LATEST_VERSION=$(curl -s https://api.github.com/repos/SagerNet/sing-box/releases/latest | jq -r .tag_name)
    
    if [ -z "$LATEST_VERSION" ]; then
        echo -e "${red}Failed to get the latest version. Please check your internet connection.${reset}"
        read -n1 -rp "$(get_text "press_key")"
        return
    fi
    
    echo -e "Latest version: ${green}$LATEST_VERSION${reset}"
    
    # Determine system architecture
    ARCH=$(uname -m)
    case $ARCH in
        x86_64) ARCH="amd64" ;;
        aarch64) ARCH="arm64" ;;
        armv7l) ARCH="armv7" ;;
        *) echo -e "${red}Unsupported architecture: $ARCH${reset}"; read -n1 -rp "$(get_text "press_key")"; return ;;
    esac
    
    # Download Sing-Box
    DOWNLOAD_URL="https://github.com/SagerNet/sing-box/releases/download/${LATEST_VERSION}/sing-box-${LATEST_VERSION#v}-linux-${ARCH}.tar.gz"
    
    echo -e "${yellow}Downloading Sing-Box...${reset}"
    wget -O /tmp/sing-box.tar.gz $DOWNLOAD_URL || { check_error "Failed to download Sing-Box"; return; }
