# Install net-tools
sudo apt install net-tools

# check port 
sudo netstat -tulpan | grep ssh

# change port
sudo nano /etc/ssh/sshd_config

# restrt ssl
sudo systemctl restart ssh

