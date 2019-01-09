#!/bin/bash 

#if [ "$EUID" -ne 0 ]; then 
#	echo "Please run as root (use sudo)"
#	exit
#fi

SETUP_DIR="$HOME/gpu-setup"
if [ ! -d $SETUP_DIR ]; then
	echo "Setup directory not found. Did you run part 1?"
	exit
fi
cd $SETUP_DIR

# install cudnn
if [ ! -f "cudnn-9.0-linux-x64-v7.4.2.24.tgz" ]; then
    echo "You need to download cudnn-9.0 manually this can be downloaded from https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.4.2/prod/9.0_20181213/cudnn-9.0-linux-x64-v7.4.2.24.tgz you will need to create a NVIDIA Account! Specifically, place it at: $SETUP_DIR/cudnn-9.0-linux-x64-v7.4.2.24.tgz"
    exit
fi

echo "Installing CUDA toolkit and samples"
# install cuda toolkit
if [ ! -f "cuda_9.0.176_384.81_linux-run" ]; then
	echo "CUDA installation file not found. Did you run part 1?"
	exit
fi
sudo sh cuda_9.0.176_384.81_linux-run --silent --verbose --driver --toolkit

echo "Uncompressing cudnn"
tar xzvf cudnn-9.0-linux-x64-v7.4.2.24.tgz
sudo cp -P cuda/include/cudnn.h /usr/local/cuda/include/
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64/
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

# update bashrc
echo "Updating bashrc"
echo >> $HOME/.bashrc '
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME=/usr/local/cuda
'

source $HOME/.bashrc

# create bash_profie
echo "Creating bash_profile"
echo > $HOME/.bash_profile '
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
'

# other Tensorflow dependencies
sudo apt-get -y install libcupti-dev

# upgrade pip
sudo pip3 install --upgrade pip3

# install latest Tensorflow with gpu support
sudo pip3 install tensorflow-gpu

echo "Script done"

