#!/bin/bash

# Script version (for update checks)
SCRIPT_VERSION="1.1.0"

# Colors
red="\e[31m"; green="\e[32m"; yellow="\e[33m"; blue="\e[34m"; reset="\e[0m"

# Banner
print_banner() {
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
  sleep 1
}

# Error handling function
check_error() {
  if [ $? -ne 0 ]; then
    echo -e "${red}ERROR: $1${reset}"
    read -n1 -rp $'Press any key to return to menu...'
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
  echo -e "16. Install RPTraefik Tunnel ${yellow}[NEW]${reset}"
  echo -e "17. Install WARP Socks5 Proxy ${yellow}[NEW]${reset}"
  echo -e "18. Get Local IPv6 from Website ${yellow}[NEW]${reset}"
  echo -e "${green}19. Check Services Status ${yellow}[NEW]${reset}"
  echo -e "${green}20. Backup System ${yellow}[NEW]${reset}"
  echo -e "${green}21. Uninstall Menu ${yellow}[NEW]${reset}"
  echo -e "${green}22. Monitor System Resources ${yellow}[NEW]${reset}"
  echo -e "${green}23. Security Menu ${yellow}[NEW]${reset}"
  echo -e "${green}24. Check for Script Updates ${yellow}[NEW]${reset}"
  echo -e "25. Exit"
  echo -ne "\nSelect an option: "
}

# Original functions
update_server_and_prereqs() {
  echo -e "${yellow}Updating system and installing prerequisites...${reset}"
  
  apt-get update || { check_error "Failed to update repository"; return; }
  apt-get upgrade -y || { check_error "Failed to upgrade packages"; return; }
  apt-get dist-upgrade -y || { check_error "Failed to perform distribution upgrade"; return; }
  
  echo -e "${green}System updated successfully.${reset}"
  read -n1 -rp $'Press any key to return to menu...'
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
  read -n1 -rp $'Press any key to return to menu...'
}

install_mhsanaei_xui() {
  echo -e "${green}Installing MHSanaei X-UI...${reset}"
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
  if [ -z "$country" ]; then
    echo -e "${red}Failed to detect server location.${reset}"
  else
    echo -e "\nServer Location: ${green}$country${reset}"
  fi
  
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
    echo -e "${yellow}Installing WARP (fscarmen)...${reset}"
    
    install_dependencies wget bc || { check_error "Failed to install dependencies"; return; }
    
    wget -N https://gitlab.com/fscarmen/warp/-/raw/main/menu.sh || { check_error "Failed to download WARP script"; return; }
    bash menu.sh

    CONFIG_FILE="/etc/wireguard/proxy.conf"
    NEW_ENDPOINT="engage.cloudflareclient.com:2408"

    if [ -f "$CONFIG_FILE" ]; then
        echo -e "${yellow}Editing $CONFIG_FILE and replacing Endpoint...${reset}"
        sed -i '/^Endpoint = /c\Endpoint = '"$NEW_ENDPOINT" "$CONFIG_FILE"
        sed -i '/^$/d' "$CONFIG_FILE"  # Remove empty lines
    else
        echo -e "${red}File proxy.conf not found. Operation canceled.${reset}"
        read -n1 -rp $'Press any key to return to menu...'
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
    read -n1 -rp $'Press any key to return to menu...'
}

# New functions from previous update
install_rptraefik() {
    echo -e "${yellow}Installing RPTraefik Tunnel...${reset}"
    echo -e "This will install RPTraefik Tunnel from dev-ir repository."
    
    install_dependencies git || { check_error "Failed to install git"; return; }
    
    echo -e "${yellow}Cloning RPTraefik repository and starting installation...${reset}"
    sudo git clone https://github.com/dev-ir/RPTraefik.git /opt/RPTraefik || { check_error "Failed to clone repository"; return; }
    cd /opt/RPTraefik && bash main.sh
    
    echo -e "${green}RPTraefik Tunnel installation completed.${reset}"
    read -n1 -rp $'Press any key to return to menu...'
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
    
    read -n1 -rp $'Press any key to return to menu...'
}

# New enhanced functions
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
    
    echo -e "${blue}=======================================================${reset}"
    read -n1 -rp $'Press any key to return to menu...'
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
            cp -r "/usr/local/x-ui/bin/config" "$backup_dir/x-ui/" || echo -e "${red}Failed to backup X-UI config directory${reset}"
        fi
        echo -e "${green}X-UI configuration backed up.${reset}"
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
    
    # Create backup archive
    echo -e "${yellow}Creating backup archive...${reset}"
    tar -czf "${backup_dir}.tar.gz" -C "$(dirname "$backup_dir")" "$(basename "$backup_dir")" || { check_error "Failed to create backup archive"; return; }
    
    # Remove the directory to save space, keep only the archive
    rm -rf "$backup_dir"
    
    echo -e "\n${green}Backup completed successfully!${reset}"
    echo -e "Backup file: ${green}${backup_dir}.tar.gz${reset}"
    echo -e "Note: To restore from backup, use: tar -xzf ${backup_dir}.tar.gz -C /"
    
    read -n1 -rp $'Press any key to return to menu...'
}

# Uninstall menu and functions
print_uninstall_menu() {
    clear
    echo -e "${blue}==================== Uninstall Menu ====================${reset}"
    echo -e "1. Uninstall X-UI Panel"
    echo -e "2. Uninstall WARP"
    echo -e "3. Uninstall WARP Socks5"
    echo -e "4. Uninstall HAProxy Tunnel"
    echo -e "5. Uninstall RPTraefik Tunnel"
    echo -e "6. Uninstall Nebula Tunnel"
    echo -e "7. Return to Main Menu"
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
    
    read -n1 -rp $'Press any key to return to menu...'
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
    
    read -n1 -rp $'Press any key to return to menu...'
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
    
    read -n1 -rp $'Press any key to return to menu...'
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
    
    read -n1 -rp $'Press any key to return to menu...'
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
    
    read -n1 -rp $'Press any key to return to menu...'
}

uninstall_nebula() {
    echo -
