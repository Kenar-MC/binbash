#!/bin/bash

# Sunucu IP'si ve SSH bağlantı bilgileri
SERVER="sunucu_ip_adresi"
USER="kullanici_adi"

# SSH komutuyla sunucuya bağlanıp bilgileri toplar
ssh "$USER@$SERVER" 'bash -s' <<'ENDSSH'
echo "---- Sunucu Ağ Bilgileri ----"

# Hostname
hostname=$(hostname)
echo "Hostname: $hostname"

# Default Gateway
default_gateway=$(ip route | grep default | awk '{print $3}')
echo "Default Gateway: ${default_gateway:-"Bulunamadı"}"

# Kullanılan ağ arayüzü ve IP adresi
interface=$(ip route | grep default | awk '{print $5}')
echo "Kullanılan Arayüz: ${interface:-"Bulunamadı"}"

# Arayüz IP adresi
ip_address=$(ip -o -4 addr show $interface | awk '{print $4}' | cut -d'/' -f1)
echo "IP Adresi: ${ip_address:-"Bulunamadı"}"

echo "------------------------------"
ENDSSH
