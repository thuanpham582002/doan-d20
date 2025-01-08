sudo sed -i 's#http://gitlab.example.com#http://gitlab.noroom113.com#g' /etc/gitlab/gitlab.rb
# Stop unnecessary services
sudo gitlab-ctl stop unicorn
# stop prometheus
sudo gitlab-ctl stop prometheus

# Configure nginx settings
sudo sed -i 's/# nginx\['\''enable'\''\] = true/nginx\['\''enable'\''\] = true/' /etc/gitlab/gitlab.rb
sudo sed -i 's/# nginx\['\''client_max_body_size'\''\] = '\''250m'\''/nginx\['\''client_max_body_size'\''\] = '\''250m'\''/' /etc/gitlab/gitlab.rb
sudo sed -i 's/# nginx\['\''redirect_http_to_https'\''\] = false/nginx\['\''redirect_http_to_https'\''\] = false/' /etc/gitlab/gitlab.rb
sudo sed -i 's/# nginx\['\''redirect_http_to_https_port'\''\] = 80/nginx\['\''redirect_http_to_https_port'\''\] = 80/' /etc/gitlab/gitlab.rb

# Configure SSL settings
sudo sed -i 's/# nginx\['\''ssl_client_certificate'\''\] = "\/etc\/gitlab\/ssl\/ca.crt"/nginx\['\''ssl_client_certificate'\''\] = "\/etc\/gitlab\/ssl\/ca.crt"/' /etc/gitlab/gitlab.rb
sudo sed -i 's/# nginx\['\''ssl_verify_client'\''\] = "off"/nginx\['\''ssl_verify_client'\''\] = "off"/' /etc/gitlab/gitlab.rb
sudo sed -i 's/# nginx\['\''ssl_verify_depth'\''\] = "1"/nginx\['\''ssl_verify_depth'\''\] = "1"/' /etc/gitlab/gitlab.rb
sudo sed -i 's/# nginx\['\''ssl_certificate'\''\] = "\/etc\/gitlab\/ssl\/#{node\['\''fqdn'\''\]}.crt"/nginx\['\''ssl_certificate'\''\] = "\/etc\/gitlab\/ssl\/gitlab.noroom113.com.crt"/' /etc/gitlab/gitlab.rb
sudo sed -i 's/# nginx\['\''ssl_certificate_key'\''\] = "\/etc\/gitlab\/ssl\/#{node\['\''fqdn'\''\]}.key"/nginx\['\''ssl_certificate_key'\''\] = "\/etc\/gitlab\/ssl\/gitlab.noroom113.com.key"/' /etc/gitlab/gitlab.rb
# Disable Let's Encrypt
sudo sed -i 's/# letsencrypt\['\''enable'\''\] = true/letsencrypt\['\''enable'\''\] = false/' /etc/gitlab/gitlab.rb


sudo gitlab-ctl reconfigure
sudo gitlab-ctl restart