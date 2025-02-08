#!/bin/bash

set -x
set -e

# 环境准备
eval "$(conda shell.bash hook)"
conda env list
rm -rfv ./_aienv
conda create --prefix ./_aienv -y python=3.10.13
conda activate ./_aienv
conda info
# 环境准备

# 初始化环境
git submodule update --init --recursive
conda install -y -c conda-forge ffmpeg
#sudo apt -y install libgl1
#pip install -r requirements.txt
#mkdir -p _cache/torch/hub/checkpoints
#huggingface-cli download ByteDance/LatentSync --local-dir _cache/torch/hub/checkpoints --exclude "*.git*" "README.md"
#mkdir -p ~/.cache/torch/hub/checkpoints
#ln -s $(pwd)/checkpoints/auxiliary/2DFAN4-cd938726ad.zip ~/.cache/torch/hub/checkpoints/2DFAN4-cd938726ad.zip
#ln -s $(pwd)/checkpoints/auxiliary/s3fd-619a316812.pth ~/.cache/torch/hub/checkpoints/s3fd-619a316812.pth
#ln -s $(pwd)/checkpoints/auxiliary/vgg16-397923af.pth ~/.cache/torch/hub/checkpoints/vgg16-397923af.pth
# 初始化环境

# 构建
#python -m py_compile webui.py
#mv __pycache__/webui.cpython-38.pyc webui.pyc
# 构建

# 启动服务
# python webui.pyc
# 启动服务

# 清除文件
rm -rfv .git || true
rm -rfv .github || true
find . -type d -name "__pycache__" -print -exec rm -r {} +
sudo rm -rf "/usr/local/share/boost"
sudo rm -rf "$AGENT_TOOLSDIRECTORY"
# 清除文件

# 打包服务
VERSION=$(python -m _aigcpanel.build)
VERSION_ARCH=$(echo $VERSION | awk -F '-' '{print $1"-"$2}')
echo "VERSION: ${VERSION}"
echo "VERSION_ARCH: ${VERSION_ARCH}"
curl -o launcher "https://modstart-lib-public.oss-cn-shanghai.aliyuncs.com/aigcpanel-server-launcher/launcher-${VERSION_ARCH}"
chmod +x launcher
curl -o binary/ffmpeg "https://modstart-lib-public.oss-cn-shanghai.aliyuncs.com/ffmpeg/ffmpeg-${VERSION_ARCH}"
chmod +x binary/ffmpeg
curl -o binary/ffprobe "https://modstart-lib-public.oss-cn-shanghai.aliyuncs.com/ffprobe/ffprobe-${VERSION_ARCH}"
chmod +x binary/ffprobe
#rm -rfv "_aigcpanel"
zip -rv "./aigcpanel-server-latentsync-${VERSION}.zip" *
# 打包服务

