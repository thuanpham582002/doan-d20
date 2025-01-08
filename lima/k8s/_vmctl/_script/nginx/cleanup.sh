sudo systemctl stop nginx
sudo apt remove nginx nginx-common
sudo apt purge nginx nginx-common
sudo rm -rf /etc/nginx /var/log/nginx