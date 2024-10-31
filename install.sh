#!/bin/bash
sudo apt update;
sudo apt install -y nodejs npm;

# install go
mkdir /root/soft;
cd /root/soft;
wget https://golang.google.cn/dl/go1.22.0.linux-amd64.tar.gz;
sudo tar xfz go1.22.0.linux-amd64.tar.gz -C /usr/local;

echo "\nexport GOROOT=/usr/local/go\nexport GOPATH=\$HOME/gowork\nexport GOBIN=\$GOPATH/bin\nexport PATH=\$GOPATH:\$GOBIN:\$GOROOT/bin:\$PATH" | sudo tee -a /etc/profile
source /etc/profile;

# install zmq 
sudo apt-get install -y pkg-config;
sudo apt-get install -y libzmq3-dev;

# install netplan
sudo apt install -y openvswitch-switch;
sudo sed -i '/dhcp6: false/a \
            addresses:\n              - 192.168.1.232/32\n              - 192.168.1.233/32\n              - 192.168.1.234/32\n              - 192.168.1.235/32\n              - 192.168.1.236/32\n              - 192.168.1.237/32\n              - 192.168.1.238/32\n              - 192.168.1.239/32\n              - 192.168.1.240/32' /etc/netplan/50-cloud-init.yaml;
cp /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.bak;
netplan apply;

# install code
mkdir /root/code;
cd /root/code;
git clone https://github.com/drinkthere/okxmm_utils.git
cd okxmm_utils;
npm install;

git clone https://github.com/drinkthere/bestpath.git
cd /root/code/bestpath;
make build;
mkdir bin/logs;
