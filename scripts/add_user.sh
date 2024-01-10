#!/bin/bash

# Add user
adduser yura

# Add rules
usermod -aG sudo yura
usermod -aG yura www-data

# Reebot
reboot
