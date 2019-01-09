#!/bin/bash

#if [ "$EUID" -ne 0 ]; then
#	echo "Please run as root (with sudo)"
#	exit
#fi

SETUP_DIR="$HOME/gpu-setup"
mkdir -p $SETUP_DIR
cd $SETUP_DIR

# update apt-get
sudo apt-get -y update

# install python libraries
sudo apt-get -y install python3-numpy python3-dev python3-wheel python3-mock python3-matplotlib python3-pip

https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run

# install cuda drivers
if [ ! -f "cuda_9.0.176_384.81_linux-run" ]; then
	wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run	
fi
chmod +x cuda_9.0.176_384.81_linux-run
sudo sh cuda_9.0.176_384.81_linux-run --silent --verbose --driver

echo "Setup requires a reboot to continue."
echo "The VM will reboot now. Login after it restarts and continue installation from part2."

#sudo reboot
