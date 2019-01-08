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

# install cuda drivers
if [ ! -f "cuda_10.0.130_410.48_linux.run" ]; then
	echo "please visit https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_type=runfilelocal to download .run file of cuda."
fi
chmod +x cuda_10.0.130_410.48_linux.run
sudo sh cuda_10.0.130_410.48_linux.run --silent --verbose --driver

echo "Setup requires a reboot to continue."
echo "The VM will reboot now. Login after it restarts and continue installation from part2."

#sudo reboot
