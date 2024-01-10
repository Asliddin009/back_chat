
sudo netstat -ntlp | grep LISTEN

sudo nano /etc/default/ufw

sudo ufw default deny incoming

sudo ufw default allow outgoing

sudo ufw allow 8585

sudo ufw allow 8500

# 30 sec default 6 cons
sudo ufw limit ssh/tcp

sudo ufw enable

sudo ufw status