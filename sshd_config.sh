#!/bin/bash

# Sunucu IP'si ve SSH bağlantı bilgileri
SERVER="sunucu_ip_adresi"
USER="kullanici_adi"

# SSH komutuyla sunucuya bağlanıp sshd_config dosyasını analiz eder
ssh "$USER@$SERVER" 'bash -s' <<'ENDSSH'
# sshd_config dosyasının yolu
CONFIG_FILE="/etc/ssh/sshd_config"

# Önemli ayarları kontrol et ve çıktı ver
echo "---- SSHD Configuration Summary ----"

# PermitRootLogin
permit_root=$(grep -Ei '^PermitRootLogin' $CONFIG_FILE | awk '{print $2}')
echo "PermitRootLogin: ${permit_root:-"Not set"}"

# PasswordAuthentication
password_auth=$(grep -Ei '^PasswordAuthentication' $CONFIG_FILE | awk '{print $2}')
echo "PasswordAuthentication: ${password_auth:-"Not set"}"

# PubkeyAuthentication
pubkey_auth=$(grep -Ei '^PubkeyAuthentication' $CONFIG_FILE | awk '{print $2}')
echo "PubkeyAuthentication: ${pubkey_auth:-"Not set"}"

# SSH Port
ssh_port=$(grep -Ei '^Port' $CONFIG_FILE | awk '{print $2}')
echo "SSH Port: ${ssh_port:-"Default (22)"}"

# PermitEmptyPasswords
empty_passwords=$(grep -Ei '^PermitEmptyPasswords' $CONFIG_FILE | awk '{print $2}')
echo "PermitEmptyPasswords: ${empty_passwords:-"Not set"}"

# Ayarlar dosyada tanımlı değilse varsayılan değerler geçerli olabilir
echo "------------------------------------"
ENDSSH
