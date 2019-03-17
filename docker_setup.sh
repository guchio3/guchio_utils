# install docker and the related utils
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# check the number of args
if [ $# -ne 1 ]; then
    echo "invalid # of args"
    echo "your's is $#, but only 1 (cpu or gpu) is needed."
fi

# update apt
sudo apt update

# ---- install docker ----
# refer to https://qiita.com/spiderx_jp/items/32c421fd00c6ade19720
# 必要なパッケージをインストールします。
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Docker公式のGPGキーを取得・追加します。
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# aptリポジトリにdockerのリポジトリを追加します。
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# 再度、aptをアップデートします。
sudo apt update

# Docker CEのインストールを行います。
sudo apt-get install -y docker-ce

# add me to the user group
sudo gpasswd -a $(whoami) docker



# ---- install docker compose ----
# refer to 
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


#  ---- install nvidia-docker2 ----
# it is install only if the arg1 is "gpu"
if [ $1 = gpu ]; then
    # aptリポジトリに必要なパッケージリポジトリパスを追加します
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
    sudo apt-get update
    # nvidia-docker 2.0をインストールします。
    sudo apt-get install -y nvidia-docker2
    # dockerのデーモン設定をリロードします。
    sudo pkill -SIGHUP dockerd
    echo "finished! successfully installed docker for GPU!"
elif [ $1 = cpu ]; then
    echo "finished! successfully installed docker for CPU!"
fi


# ---- setting docker ----
mkdir ~/.docker
cd ~/ && ln -s $SCRIPT_DIR/.docker/config.json ./.docker/config.json
