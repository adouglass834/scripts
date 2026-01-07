#!/bin/bash


# Replace with your token and chat_id 
TOKEN="8014373097:AAH-2688xNO3LM71lV2xFgDqjM6L1ynvidk" 
CHAT_ID="6637441831" 

# Function to send Telegram messages 
send_telegram_message() { 
   local message="$1" 
   curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \ 
       -d "chat_id=$CHAT_ID" \ 
       -d "text=$message" \ 
       -d "parse_mode=HTML" 
}


# Firewall and Network Security
function firewall_network() {
    log_message "Firewall and Network Security:"
    echo "Active firewall status:"
    ufw status verbose
    echo "Open ports and associated services:"
    ss -tuln
    echo "IP forwarding:"
    sysctl net.ipv4.ip_forward
    echo
}

# IP and Network Configuration Checks
function ip_network() {
    log_message "IP and Network Configuration Checks:"
    echo "IP addresses:"
    ip addr show
    echo "Public vs Private IPs:"
    # Example command - adjust for your environment
    ip -o -4 addr show | awk '{print $2, $4}'
    echo
}

# Security Updates and Patching
function security_updates() {
    log_message "Security Updates and Patching:"
    echo "Available updates:"
    apt list --upgradable | grep -i security
    echo "Checking unattended-upgrades configuration:"
    dpkg -l | grep unattended-upgrades
    echo
}

# Log Monitoring
function log_monitoring() {
    log_message "Log Monitoring:"
    echo "Recent SSH login attempts:"
    grep "sshd" /var/log/auth.log | tail -n 50
    echo
}

# Server Hardening Steps
function server_hardening() {
    log_message "Server Hardening Steps:"
    echo "SSH Configuration:"
    sshd_config="/etc/ssh/sshd_config"
    echo "PasswordAuthentication no" >> $sshd_config
    systemctl restart sshd
    echo "IPv6 Configuration:"
    # Example command - adjust for your environment
    echo "Disabling IPv6..."
    echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
    sysctl -p
    echo "Bootloader Security:"
    grub-mkpasswd-pbkdf2
    echo
}

# Custom Security Checks
function custom_checks() {
    log_message "Custom Security Checks:"
    # Include custom checks as defined in the configuration file
    while IFS= read -r line; do
        eval $line
    done < $CONFIG_FILE
    echo
}

# Generate Report
function generate_report() {
    log_message "Generating Security Report:"
    cat $LOG_FILE
}

# Main Function
function main() {
    user_group_audit
    file_permissions
    service_audit
    firewall_network
    ip_network
    security_updates
    log_monitoring
    server_hardening
    custom_checks
    generate_report
}

# Run the main function
main
