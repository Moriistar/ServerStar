#!/bin/bash

# Colors
red="\e[31m"; green="\e[32m"; yellow="\e[33m"; blue="\e[34m"; reset="\e[0m"

print_menu() {
  clear
  echo -e "${blue}==================== ServerStar Menu ====================${reset}"
  echo -e "1. Install X-UI Panel (MHSanaei)"
  echo -e "2. Install TX-UI Panel (AghayeCoder)"
  echo -e "3. Install Alireza X-UI Panel (v1.8.9)"
  echo -e "4. Install TX-UI Theme"
  echo -e "5. Install Automatic Backup (AC_Lover)"
  echo -e "6. Install Haproxy Tunnel (IPv4/IPv6)"
  echo -e "7. Install Nebula Tunnel"
  echo -e "8. Optimize Xray with WARP"
  echo -e "9. Telegram Monitor"
  echo -e "10. Detect Server Location"
  echo -e "11. Generate Random Local IPv6"
  echo -e "12. Manual Tunnel Setup (Input IP)"
  echo -e "13. Exit"
  echo -ne "\nSelect an option: "
}

# Each function:
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

# Menu loop
while true; do
  print_menu
  read -r option
  case $option in
    1) install_mhsanaei_xui ;;
    2) install_txui ;;
    3) install_alireza_xui ;;
    4) install_txui_theme ;;
    5) install_backup_script ;;
    6) install_haproxy_tunnel ;;
    7) install_nebula ;;
    8) optimize_xray_warp ;;
    9) setup_telegram_monitor ;;
    10) check_location ;;
    11) generate_ipv6 ;;
    12) manual_tunnel_setup ;;
    13) break ;;
    *) echo -e "${red}Invalid option!${reset}"; sleep 1 ;;
  esac
done

clear && echo -e "${green}Exited ServerStar Menu.${reset}"
