#!/bin/bash

# Update, upgrade , and autoremove regular updates

apt update && apt upgrade -y

# Clean up

apt autoremove -y

# Log the update

echo "Updates completed on $(date)" >> /var/log/auto_update.log

