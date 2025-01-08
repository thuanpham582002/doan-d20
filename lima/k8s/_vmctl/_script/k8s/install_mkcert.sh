sudo apt install -y libnss3-tools
wget https://dl.filippo.io/mkcert/latest?for=linux/arm64 -O mkcert
chmod +x mkcert
sudo mv mkcert /usr/local/bin/

export CAROOT=/Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/k8s/_vmctl/_script/certificate
mkcert -install