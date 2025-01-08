#!/bin/zsh
source import_env.sh
echo "Installing .NET 6 SDK on $VM_NAME"
limactl shell $VM_NAME bash -c '
# Uninstall old version of dotnet
sudo rm -rf /usr/share/dotnet
sudo rm /usr/bin/dotnet
curl -SL -o dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/ec8e29f5-2fbe-47d8-b0c5-81f11434c00f/ba4bd30be448d649e5ddf1991bf76252/dotnet-sdk-6.0.425-linux-arm64.tar.gz
sudo mkdir -p /usr/share/dotnet
sudo tar -zxf dotnet.tar.gz -C /usr/share/dotnet
sudo ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
rm dotnet.tar.gz
dotnet --version
'
