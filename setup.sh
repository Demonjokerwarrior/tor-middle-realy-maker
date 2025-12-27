#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
  echo "[!] Please run this script as root (sudo)."
  exit 1
fi

echo "[*] Updating system packages..."
apt update && apt upgrade -y

echo "[*] Installing required packages..."
apt install -y tor nyx tcpdump ufw curl git python3 python3-pip

echo "[*] Backing up existing Tor configuration..."
if [ -f /etc/tor/torrc ]; then
  cp /etc/tor/torrc /etc/tor/torrc.backup.$(date +%F_%T)
fi

echo "[*] Writing Tor middle relay configuration..."
cat <<EOF >/etc/tor/torrc
ORPort 9001
DirPort 9030

Nickname MiddleRelayNode
ContactInfo admin@example.com

RelayBandwidthRate 1 MByte
RelayBandwidthBurst 2 MBytes

ExitPolicy reject *:*
SocksPort 0

Log notice file /var/log/tor/notices.log
RunAsDaemon 1
EOF

echo "[*] Setting permissions on Tor log directory..."
mkdir -p /var/log/tor
chown -R debian-tor:debian-tor /var/log/tor
chmod 750 /var/log/tor

echo "[*] Configuring firewall (UFW)..."
ufw allow 22/tcp
ufw allow 9001/tcp
ufw allow 9030/tcp
ufw --force enable

echo "[*] Enabling and restarting Tor service..."
systemctl enable tor
systemctl restart tor

echo "[*] Verifying Tor status..."
systemctl status tor --no-pager

echo "[*] Installing Python monitoring dependencies..."
pip3 install psutil matplotlib flask flask-socketio pyshark

echo "[*] Setup completed successfully."
echo "[*] Use 'nyx' to monitor your Tor relay."
echo "[*] Check logs at /var/log/tor/notices.log"
