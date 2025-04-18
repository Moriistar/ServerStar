# Install RPTraefik Tunnel
install_rp_traefik() {
    echo "Installing RPTraefik tunnel..."
    sudo git clone https://github.com/dev-ir/RPTraefik.git /opt/RPTraefik && cd /opt/RPTraefik && bash main.sh
}

# Install WARP as SOCKS5
install_warp_socks5() {
    echo "Installing WARP SOCKS5..."
    bash <(curl -sSL https://raw.githubusercontent.com/hamid-gh98/x-ui-scripts/main/install_warp_proxy.sh)

    # Add outbound configuration:
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
    }' >> /etc/xray/config.json

    # Add outbound rule:
    echo '{
      "type": "field",
      "outboundTag": "WARP",
      "domain": ["cloudflare.com", "iran.ir"]
    }' >> /etc/xray/config.json
}

# Get Local IPv6 Address
get_ipv6_local() {
    echo "Getting local IPv6 address..."
    curl https://unique-local-ipv6.com/ | grep -oP '(?<=<pre>)(.*?)(?=</pre>)' > /tmp/ipv6.txt
    cat /tmp/ipv6.txt
}

# Menu for selecting options
echo "16. Install RPTraefik Tunnel"
echo "17. Install WARP SOCKS5"
echo "18. Get Local IPv6 Address"
echo "19. Exit"

read -p "Choose an option: " option

case $option in
    16) install_rp_traefik ;;
    17) install_warp_socks5 ;;
    18) get_ipv6_local ;;
    19) exit 0 ;;
    *) echo "Invalid selection" ;;
esac
