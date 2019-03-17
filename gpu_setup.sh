# check the env information
echo '------ OS INFO ------'
cat /etc/lsb-release
echo ''

echo '------ USED GPU ------'
lspci | grep -i nvidia
echo ''


# install cuda 10.1
# refer to https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=debnetwork
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_10.1.105-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_10.1.105-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt-get update
sudo apt-get install -y cuda cuda-drivers
rm cuda-repo-ubuntu1604_10.1.105-1_amd64.deb
