sudo apt update
sudo apt install nfs-kernel-server -y
sudo systemctl enable nfs-kernel-server.service
sudo systemctl start nfs-kernel-server.service
sudo mkdir -p /mnt/nfs_share
sudo chown nobody:nogroup /mnt/nfs_share
sudo chmod 777 /mnt/nfs_share

# Add the following line to /etc/exports
# /mnt/nfs_share *(rw,sync,no_subtree_check,no_root_squash)
echo "/mnt/nfs_share *(rw,sync,no_subtree_check,no_root_squash)" | sudo tee -a /etc/exports

sudo exportfs -a
sudo systemctl restart nfs-kernel-server.service