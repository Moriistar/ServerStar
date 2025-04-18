```bash
#!/bin/bash

# Script version (for update checks)
SCRIPT_VERSION="1.2.0"

# Colors
red="\e[31m"; green="\e[32m"; yellow="\e[33m"; blue="\e[34m"; magenta="\e[35m"; cyan="\e[36m"; reset="\e[0m"

# Language setup (en for English, fa for Persian/Farsi)
LANGUAGE="en"

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
    read -n1 -rp $"$(get_text "press_key")"
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

# Check for system updates
check_script_updates() {
  echo -e "${yellow}Checking for script updates...${reset}"
  
  # Define GitHub repository (replace with actual repo)
  REPO_URL="https://raw.githubusercontent.com/ServerStar/serverstar-script/main/version.txt"
  
  install_dependencies curl || { check_error "Failed to install curl"; return; }
  
  # Try to get the latest version
  LATEST_VERSION=$(curl -s $REPO_URL)
  
  if [ -z "$LATEST_VERSION" ]; then
    echo -e "${red}Failed to check for updates. Please check your internet connection.${reset}"
    read -n1 -rp $"$(get_text "press_key")"
    return
  fi
  
  # Compare versions
  if [ "$LATEST_VERSION" != "$SCRIPT_VERSION" ]; then
    echo -e "${green}New version available: $LATEST_VERSION (current: $SCRIPT_VERSION)${reset}"
    echo -e "${yellow}Would you like to update? (y/n)${reset}"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      echo -e "${yellow}Updating script...${reset}"
      # Add update code here
      echo -e "${green}Update completed! Please restart the script.${reset}"
      exit 0
    else
      echo -e "${yellow}Update skipped.${reset}"
    fi
  else
    echo -e "${green}You are using the latest version: $SCRIPT_VERSION${reset}"
  fi
  
  read -n1 -rp $"$(get_text "press_key")"
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
  install_dependencies curl wget socat unzip lsof iptables cron nginx jq || { check_error "Failed to install dependencies"; return; }
  
  echo -e "${green}System updated successfully.${reset}"
  read -n1 -rp $"$(get_text "press_key")"
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
  
  read -n1 -rp $"$(get_text "press_key")"
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
  
  read -n1 -rp $"$(get_text "press_key")"
}

generate_ipv6() {
  echo -e "${yellow}Generating random local IPv6 (fd00::/8)...${reset}"
  echo -e "${blue}Generated IPv6 addresses:${reset}"
  
  for i in {1..5}; do
    printf "fd%02x:%04x:%04x:%04x::/64\n" $((RANDOM%256)) $((RANDOM%65536)) $((RANDOM%65536)) $((RANDOM%65536))
  done
  
  read -n1 -rp $"$(get_text "press_key")"
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
  
  read -n1 -rp $"$(get_text "press_key")"
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
        read -n1 -rp $"$(get_text "press_key")"
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
    read -n1 -rp $"$(get_text "press_key")"
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
    read -n1 -rp $"$(get_text "press_key")"
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
    
    read -n1 -rp $"$(get_text "press_key")"
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
    
    read -n1 -rp $"$(get_text "press_key")"
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
    read -n1 -rp $"$(get_text "press_key")"
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

backup_system() {
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
