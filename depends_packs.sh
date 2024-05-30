#!/bin/bash
# Update packages
apt-get update
# Non-interactive mode, use default answers
export DEBIAN_FRONTEND=noninteractive
# Workaround for libc6 bug - asking about service restart in non-interactive mode
echo 'libc6 libraries/restart-without-asking boolean true' | debconf-set-selections
# Install Python 3.10
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get -y install python3.10 python3.10-dev python3.10-distutils
curl https://bootstrap.pypa.io/get-pip.py | sudo python3.10
# Add Nvidia repositories for Ubuntu 22.04 (change this if using another version)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
# Install the latest NVIDIA driver and CUDA toolkit
#It says the latest version is Driver Version: 552.22
sudo apt-get -y install --no-install-recommends cuda-drivers
sudo apt-get -y install --no-install-recommends cuda-toolkit-12-4
#Definitely not sure if this correct or needed but I couldn't find good info on what libvinfer to use.
apt-get -y install --no-install-recommends libnvinfer libnvinfer-dev
# Install cuDNN compatible with CUDA 12
sudo apt-get -y install cudnn9-cuda-12

pip3 install tensorflow
# Install PyTorch (compatible with CUDA 12)
pip3 install torch torchvision torchaudio
# Install other Python packages
pip3 install --upgrade numpy python-pandas matplotlib tqdm pexpect opencv-python deepspeed transformers einops pycocotools kornia beartype datasets click sentencepiece enum typing flatbuffers
# Optional: Additional packages mentioned
pip3 install --upgrade xml pathlib striprtf ast copy math contextlib functools collections pytorch_warmup lion_pytorch packaging ema_pytorch fsspec scipy csv re triton pydantic paramiko

pip3 install --upgrade deepspeed transformers einops pycocotools kornia beartype datasets sentencepiece striprtf pytorch_warmup lion_pytorch ema_pytorch

sudo systemctl restart nvidia-persistenced

sudo apt install --reinstall nvidia-driver-555

sudo apt update
sudo apt upgrade nvidia-driver-555

sudo apt-get update

# Reboot
sudo reboot
