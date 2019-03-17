# check the env information
echo '------ OS INFO ------'
cat /etc/lsb-release
echo ''

echo '------ USED GPU ------'
lspci | grep -i nvidia
echo ''


# install cuda 10.1
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_10.1.105-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_10.1.105-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt-get update
sudo apt-get install -y cuda cuda-drivers
rm cuda-repo-ubuntu1604_10.1.105-1_amd64.deb


# install cuda 9.2
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_10.0.130-1_amd64.deb
#sudo dpkg -i cuda-repo-ubuntu1604_10.0.130-1_amd64.deb
#rm -f cuda-repo-ubuntu1604_10.0.130-1_amd64.deb
#sudo apt-get update
# sudo apt-get install cuda nvidia-cuda-toolkit
#echo '------ CUDA VERSION ------'
#nvcc -V
#echo ''


# install nvidia docker
# sudo apt-get install -y nvidia-docker2=2.0.3+docker18.09.2 nvidia-container-runtime=2.0.0+18.09.2
