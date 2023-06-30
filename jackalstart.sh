#!/bin/bash

#update package lists

apt update

apt upgrade

#Install dependencies

apt install build-essential lz4 jq -y
snap install go --classic

# Add Go to .profile
echo '# add environmental variables for Go' >> ~/.profile
echo 'if [ -f "/usr/local/go/bin/go" ] ; then' >> ~/.profile
    echo '    export GOROOT=/usr/local/go' >> ~/.profile
    echo '    export GOPATH=${HOME}/go' >> ~/.profile
    echo '    export GOBIN=$GOPATH/bin' >> ~/.profile
    echo '    export PATH=${PATH}:${GOROOT}/bin:${GOBIN}' >> ~/.profile
    echo '    export GO111MODULE=on' >> ~/.profile 
echo 'fi' >> ~/.profile

# Add Go to skeleton .profile
echo '# add environmental variables for Go' >> /etc/skel/.profile
echo 'if [ -f "/usr/local/go/bin/go" ] ; then' >> /etc/skel/.profile
    echo '    export GOROOT=/usr/local/go' >> /etc/skel/.profile
    echo '    export GOPATH=${HOME}/go' >> /etc/skel/.profile
    echo '    export GOBIN=$GOPATH/bin' >> /etc/skel/.profile
    echo '    export PATH=${PATH}:${GOROOT}/bin:${GOBIN}' >> /etc/skel/.profile
    echo '    export GO111MODULE=on' >> /etc/skel/.profile
echo 'fi' >> /etc/skel/.profile

# Reload .profile
source ~/.profile

sudo ufw limit ssh/tcp comment 'Rate limit for openssh server'
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 26656/tcp comment 'JACKAL - Cosmos SDK/Tendermint P2P'
sudo ufw allow 26657/tcp comment 'JACKAL - Cosmos SDK/Tendermint P2P'
sudo ufw enable

sudo adduser --gecos "" jackal
sudo usermod -aG sudo jackal

sudo reboot
