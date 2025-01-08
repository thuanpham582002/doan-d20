sudo apt-get update
curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
# https://packages.gitlab.com/gitlab/gitlab-ee/packages/debian/bullseye/gitlab-ee_15.11.5-ee.0_amd64.deb
wget --content-disposition https://packages.gitlab.com/gitlab/gitlab-ee/packages/ubuntu/focal/gitlab-ee_15.11.5-ee.0_arm64.deb/download.deb
sudo apt-get install -y ./gitlab-ee_15.11.5-ee.0_arm64.deb
sudo rm -f ./gitlab-ee_15.11.5-ee.0_arm64.deb

# Change external_url to gitlab.noroom113.com in /etc/gitlab/gitlab.rb
sudo sed -i 's/^external_url.*/external_url "http:\/\/colima"/' /etc/gitlab/gitlab.rb
sudo gitlab-ctl reconfigure

echo "Gitlab is installed successfully"
echo "First password for root is "
sudo cat /etc/gitlab/initial_root_password | grep -oP 'Password: \K.*'