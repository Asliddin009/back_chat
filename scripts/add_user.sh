#!/bin/bash

# Add user
adduser asli

# Add rules
usermod -aG sudo asli
usermod -aG asli www-data

# Reebot
reboot
